Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877F64AFE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 07:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiLMG2Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 01:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiLMG2Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 01:28:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834A1F60D;
        Mon, 12 Dec 2022 22:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EB5612CC;
        Tue, 13 Dec 2022 06:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDC4C433D2;
        Tue, 13 Dec 2022 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912902;
        bh=uI9Ao0SciAAwTHod6G70GoHTrSCkbTWfoHihc8zqEeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJKrvgj/Y0j3/73ALgH3QmJwIQPSa690Ayez+uoxVpATMCgziHCrC1hCs0Kqcx5Oq
         TtghrxIVbi2E/0Wt+D7TutZN0UaF9ydIhRuBbzBLI0ZQjYGnHRtpGP3vaE93EHk+7R
         y27mw6pKl6V6B1Ylsq+k8FaeE60fhIn9nMq1U3Fk=
Date:   Tue, 13 Dec 2022 07:28:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
Message-ID: <Y5gbg820K5LHI7K6@kroah.com>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-6-benjamin.tissoires@redhat.com>
 <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
 <53f21d98-4ee6-c0e9-1c0a-5fae23c1b9a8@meta.com>
 <Y5dxAz3QTQnaB71Q@kroah.com>
 <43e6e9ec-3a0c-7238-30b2-daa7e71b169b@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e6e9ec-3a0c-7238-30b2-daa7e71b169b@meta.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 12, 2022 at 10:39:26AM -0800, Yonghong Song wrote:
> 
> 
> On 12/12/22 10:20 AM, Greg KH wrote:
> > On Mon, Dec 12, 2022 at 09:52:03AM -0800, Yonghong Song wrote:
> > > 
> > > 
> > > On 12/12/22 9:02 AM, Benjamin Tissoires wrote:
> > > > On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> wrote:
> > > > > 
> > > > > Kind of a hack, but works for now:
> > > > > 
> > > > > Instead of listening for any close of eBPF program, we now
> > > > > decrement the refcount when we insert it in our internal
> > > > > map of fd progs.
> > > > > 
> > > > > This is safe to do because:
> > > > > - we listen to any call of destructor of programs
> > > > > - when a program is being destroyed, we disable it by removing
> > > > >     it from any RCU list used by any HID device (so it will never
> > > > >     be called)
> > > > > - we then trigger a job to cleanup the prog fd map, but we overwrite
> > > > >     the removal of the elements to not do anything on the programs, just
> > > > >     remove the allocated space
> > > > > 
> > > > > This is better than previously because we can remove the map of known
> > > > > programs and their usage count. We now rely on the refcount of
> > > > > bpf, which has greater chances of being accurate.
> > > > > 
> > > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > > 
> > > > > ---
> > > > 
> > > > So... I am a little bit embarrassed, but it turns out that this hack
> > > > is not safe enough.
> > > > 
> > > > If I compile the kernel with LLVM=1, the function
> > > > bpf_prog_put_deferred() is optimized in a weird way: if we are not in
> > > > irq, the function is inlined into __bpf_prog_put(), but if we are, the
> > > > function is still kept around as it is called in a scheduled work
> > > > item.
> > > > 
> > > > This is something I completely overlooked: I assume that if the
> > > > function would be inlined, the HID entrypoint BPF preloaded object
> > > > would not be able to bind, thus deactivating HID-BPF safely. But if a
> > > > function can be both inlined and not inlined, then I have no
> > > > guarantees that my cleanup call will be called. Meaning that a HID
> > > > device might believe there is still a bpf function to call. And things
> > > > will get messy, with kernel crashes and others.
> > > 
> > > You should not rely fentry to a static function. This is unstable
> > > as compiler could inline it if that static function is called
> > > directly. You could attach to a global function if it is not
> > > compiled with lto.
> > 
> > But now that the kernel does support LTO, how can you be sure this will
> > always work properly?  The code author does not know if LTO will kick in
> > and optimize this away or not, that's the linker's job.
> 
> Ya, that is right. So for in-kernel bpf programs, attaching to global
> functions are not safe either. For other not-in-kernel bpf programs, it
> may not work but that is user's responsibility to adjust properly
> (to different functions based on a particular build, etc.).

So if in-kernel bpf programs will not work or are not safe, how will
in-kernel bpf programs properly attach?

confused,

greg k-h

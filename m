Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6253264A589
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 18:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiLLRI0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 12:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiLLRIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 12:08:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A9726E6;
        Mon, 12 Dec 2022 09:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967C060F1A;
        Mon, 12 Dec 2022 17:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1462C433D2;
        Mon, 12 Dec 2022 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864902;
        bh=2ahBXUJDAK2WR3lhgschSHf1DqybChKQYpTaViFEUFI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YzEMZW4YK13QRhfLLVHauaj5+qXYPAZCMdfk/G4b2C57WLp8hl/3qUB23QATOJeev
         r/FLXZYpLUHF03IBD4PMGBV5zvq0THkMjRWcz4XMx4Qf7cLf2nbx6/7oXGBLwu6x49
         ArDeMJsChUFK+CIhkngu+3EsuRQKCHt4PrsiUwM2+DlTjGdu68ngLjW8VQlsWrfOdt
         wKSu2Xr5hJoQ7ba+3Q5WrfZnGRUQg3t0XwWDlFGeRmQ1lX8oytYhZOmEGmZqtGXQ9m
         3lMR6rT1TlbENUP5r/Zz9kxHPGDwB6B0g+AGeHKo8hk9IQHz7rGTjJEhczpgX525Ew
         /okYoikCnvTZA==
Date:   Mon, 12 Dec 2022 18:08:20 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
In-Reply-To: <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2212121806440.9000@cbobk.fhfr.pm>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com> <20221103155756.687789-6-benjamin.tissoires@redhat.com> <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 12 Dec 2022, Benjamin Tissoires wrote:

> If I compile the kernel with LLVM=1, the function 
> bpf_prog_put_deferred() is optimized in a weird way: if we are not in 
> irq, the function is inlined into __bpf_prog_put(), but if we are, the 
> function is still kept around as it is called in a scheduled work item.
> 
> This is something I completely overlooked: I assume that if the function 
> would be inlined, the HID entrypoint BPF preloaded object would not be 
> able to bind, thus deactivating HID-BPF safely. But if a function can be 
> both inlined and not inlined, then I have no guarantees that my cleanup 
> call will be called. Meaning that a HID device might believe there is 
> still a bpf function to call. And things will get messy, with kernel 
> crashes and others.
> 
> An easy "fix" would be to tag bpf_prog_put_deferred() with "noinline",
> but it just feels wrong to have that for this specific reason.
> 
> AFAICT, gcc is not doing that optimisation, but nothing prevents it
> from doing it, and suddenly that will be a big whole in the kernel.

It's not doing it on this particular function, but in general it's 
actually quite common for gcc to inline a function in some callsites and 
leave it out-of-line in others (we are dealing with that in livepatching), 
so I agree it has to be taken into account irrespective of the compiler 
used.

> As much as I wish I had another option, I think for the sake of everyone 
> (and for my future holidays) I'll postpone HID-BPF to 6.3.

Thanks,

-- 
Jiri Kosina
SUSE Labs


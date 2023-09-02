Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332DA790A39
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjIBW66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 18:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjIBW65 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 18:58:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66ACF6;
        Sat,  2 Sep 2023 15:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 861BCB808BB;
        Sat,  2 Sep 2023 22:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5DBC433C7;
        Sat,  2 Sep 2023 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693695532;
        bh=Pc7GpWIHklekXAoIIEgvXTBTXk0POLNq+rx6i3iVkpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uWkk4/925oGsoUT/g2nfGusbL8Se07i/a4cb8oypyPMgWKTz1VKBLf34/LqJCxEM2
         eQf44uz/MUwsaZPVMCDL3/y/oCeZePc/HgtNCGU8tQlQQEt2fWNZ3jdhQQSueCyhV/
         VL+4t/bm5/BaCWpPLvOwKFrMUeTkTvA3O85omhwg=
Date:   Sat, 2 Sep 2023 15:58:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Damian Tometzki <dtometzki@fedoraproject.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Shuah Khan <shuah@kernel.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
Message-Id: <20230902155850.ca1d32c16862cbe54ebd36ef@linux-foundation.org>
In-Reply-To: <ZPFzCSIgZ4QuHsSC@fedora.fritz.box>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
        <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
        <ZPFzCSIgZ4QuHsSC@fedora.fritz.box>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 1 Sep 2023 07:13:45 +0200 Damian Tometzki <dtometzki@fedoraproject.org> wrote:

> >  	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> > -		pr_warn_once(
> > +		pr_info_ratelimited(
> >  			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
> >  			current->comm, task_pid_nr(current));
> >  	}
> > 
> > -- 
> > 2.41.0
> >
> Hello Sarai,
> 
> i got a lot of messages in dmesg with this. DMESG is unuseable with
> this. 
> [ 1390.349462] __do_sys_memfd_create: 5 callbacks suppressed
> [ 1390.349468] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
> [ 1390.350106] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set

OK, thanks, I'll revert this.  Spamming everyone even harder isn't a
good way to get developers to fix their stuff.


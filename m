Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2354C1C73
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbiBWTpg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 14:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiBWTpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 14:45:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B74B1F8
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 11:45:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 499D461770
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 19:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9370C340FD
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645645505;
        bh=6v6jF0P7IEYuMS19alLwVHQ6Tz2juOAcucIRyeumVWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I61UvHRN0Vt744x0tqqIlz3WwBBW0aVP3hyJqajnLIxlXbsgS99B39zeqCsO6yow2
         +NcTBsGZUnCp2ejji/LV8GKWEHm6giBflQYP/IOYmrBbQm+PWxc1IyyI3G6NEt3gUh
         G4EsYcFF3w6kW4Mv4EMLOCfnBydFjFFVfBFNhFbxfio9f0W5fKoZNbsCd7xeSeRaaG
         l2TEZmsNgernS2AQ3s5m/PdAJjR1bctTiEl/bnRb08j6YYXtzwFUgeYM/2GCJjBNF7
         APrfMqJljngF5nK6yvXWmikMfw7h0z/fUyQD1CkbHKgKiR/PcIvDKMt8O/7//lQ7E/
         67xGStzgNE0ng==
Received: by mail-ej1-f46.google.com with SMTP id p14so54568597ejf.11
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 11:45:05 -0800 (PST)
X-Gm-Message-State: AOAM532X0LQwN6kXrUtNWkqE/0xgF7UADW/lgvlpEvlW476HyvbdkVH3
        o3vwavB1p6kZ1BBOb+lkHLl0gwcnxVhM6byWSB59qw==
X-Google-Smtp-Source: ABdhPJwZyitZOOWhhPDDfv051tWufIzI5PoAeGpdvPbapPOSXAFYCwmW3gmz+M4158AWX/TxdBOznwf75drzcBBKylU=
X-Received: by 2002:a17:906:646:b0:6ce:a6fb:2854 with SMTP id
 t6-20020a170906064600b006cea6fb2854mr893331ejb.675.1645645503667; Wed, 23 Feb
 2022 11:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20220207121800.5079-1-mkoutny@suse.com> <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz> <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Feb 2022 11:44:51 -0800
X-Gmail-Original-Message-ID: <CALCETrVh8Xu3VJzseWEJZ+ryy5WANyJg+j4=hFaVFebzSu_TgQ@mail.gmail.com>
Message-ID: <CALCETrVh8Xu3VJzseWEJZ+ryy5WANyJg+j4=hFaVFebzSu_TgQ@mail.gmail.com>
Subject: Re: How should rlimits, suid exec, and capabilities interact?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-api@vger.kernel.org, Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        security@kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
        NeilBrown <neilb@suse.de>, "Serge E. Hallyn" <serge@hallyn.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 23, 2022 at 10:00 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> [CC'd the security list because I really don't know who the right people
>  are to drag into this discussion]
>
> While looking at some issues that have cropped up with making it so
> that RLIMIT_NPROC cannot be escaped by creating a user namespace I have
> stumbled upon a very old issue of how rlimits and suid exec interact
> poorly.

Once upon a time, these resource limits were effectively the only way
to control memory consumption and consumption of historically limited
resources like processes.  (The scheduler used to have serious issues
with too many processes -- this is not so true any more.  And without
cgroups, too many processes could use too much CPU collectively.)
This all worked pretty poorly.  Now we have cgroups, fancy memory
accounting, etc.  So I'm wondering if NPROC is even useful anymore.  I
don't have a brilliant idea of how to deprecate it, but I think it
wouldn't be entirely nuts to take it much less seriously and maybe
even eventually get rid of it.

I doubt there is much existing userspace that would break if a
previously failing fork() started succeeding.

--Andy]

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9764B89A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiLMPhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 10:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiLMPhj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 10:37:39 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D42AE
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Dec 2022 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670945857; bh=sOXTvqDHnS4t0uRzxe63xLlgmapSCpal4VxqiUQzZfY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ktBwd0juCNCyftgkH/v6HItWujJzkDbV6II6HgFPm/HK7iYA8Abcn2y09r8uJYL1o3ks24RAao8lscyQrxjUwW5EveBq6t4xSVXYQ+13fHPUGtuH2poZ/z+Ki6ihszCy3cY3K5QV1/uVu8E3OmbS/2LJXm/Kvbx6IoMFYBxGP80OdV/axUoRCHnqrAb3zHEhOhV7qrNoDduuXji62ysK/oXhjwfoXcCTYfdhoBv4niMrcqQNsa4dP8jAlJvwyQtQuzboldXiaaUwsYcAo+30eGXqlmcOd5cC/SHeXGRTFn8Q9PVZ2JJqt8TYU3GAC7gAV2K1U0IH3Nz/tynmVFCeVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670945857; bh=YE8ZkhyNRLmPKVNTfcmDsM+qMFWCw6ikwyDaV6WZlvm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oHkq+rd0Q9v5YWGTefru/kLOj333xla7iY0veZn376G59o7JM5NtYiAQLbVOl3kxPtXeyIH4Jhyu8FLMGnoD3lxOvNDy4jF3zxFMubBb/A8U1nYTeIwY3EfayjIXdSN6fXceAzicsDGvpptuwj9BxszzZf6yiCXkH310cItGDf2HAx/xrHAVwC0+O0E2eW507Z5+2Za/HOKCLzXvLtlQv8UGmN3dukeJiruuanOqJM2HlMs/VMShO2Azj1/z2Cr1m/Os8kZe5KOrxhJrZH5CIjnr0s2bBWnATMdK5Y1RBL7cUtGHgiLa3DDRQwFP3b2yE2fMzQGtciEqbbTaION4Rw==
X-YMail-OSG: 8_.lebkVM1mnfFj1NWh627alP1i_ua7hWW8AtL6Ad1BcugYWlVF5nGf7bzaZ7Xt
 Z9sGg.t5dloDbIlO1IxKcE3XzLritBcM0xZGtoxVpIkMfPVWMDibeuKzPE8Cue44njKArVsI.dsz
 TZwQbNdvJsrcJZgH47cpgVFAVI6hwiApZGdHBQQm_x.slZ_w1X_qIlUCmVhk8IjZM7JsQ_McgPjI
 oieXOL0F5YfknpdVDQOPi77G8At1DgxEHsB9XL0Id0hVZxiHauHjJf_CFfkuVxtZYFg8dClLshUD
 Pi5j5VSyJWgRq5ptD1WWgq0iZG2YkEiplUw0hrOm8DGInhNLr6yjQrKGBNKbplAq9isC31qbiXXk
 emZe_2ThPXRr48_8BiZuTr_j66NACensRf1sQpepg4vIwmRQx1003l1HEH8tUSZjoSIulESNwa81
 8BxixZvR6ysiZeJRPdFeNpkhHiI9I3PssAEzMvTB6OGmxB91jNj7UoC0vyxxgdFz3xAt.MV3hHlk
 qZ1Jc9gYTcGG77yAiNBi3HvyJokPqKetjO7gNA_xOhY2ulIr43d1beSKSP7JHmDHeQHZE7JpeAYC
 LjIFyUj4OeNqWZsJ54LZx28BGlqi60Yz48bLo4ZqFvhMAMO5plbeMCKsalLRP9W.YuNYVzDUjwhF
 W5qeQA2w48Gzw8H9N_yDlZuz9bgP12L6igri5HPTUhU_DLfRtUuCcehGvkmsAt4SwKdEopROBdKb
 P1hwQ2zqdMWkTnNhPpbDSXxFEW_ragx8Polq9W3IFUzf2DSNytuPEtl90tJKe1bzYPYtywSx7YGG
 QjNJleCYlKVUubn6C3oQj_HRcQC_ebsTjsHaL4cFAjpwl2LNr6Gz4wLLV1_rBl3MldaeFAT69yQp
 GZziZ6s8RcXrGLbr2vL55OpprCxRz0dJJFvLTquR9auMmnQkvWPi9eo9BRdIjvGIIB0clfToHmeM
 muOlzSrGZkh5dQIfERIT8hGBpTEJaEXsolM_fdHiZS_T33vVZmckopEUAkaJ0UDCBxSj4psewgb9
 _n5HlPbqiH0zPiQEBSzjCsROIosXYmKTtLq0w0xdRedbKJNaSQ6yKRZwONOOc9_oFA3gT5VN_8Yq
 cjiJLr8UlR5dMC5Wiyii5ZinFeqRX6HB.AGsjVDJYpB9RbzPErcZa9OEIWrV6W_gjHh8jiZV8pm2
 XSSDeO1v5qI6J.8FWgWqtoJd5RHit8mO_alhGbjSQfWGXj2JNyyBT3ZwsOgXps9eNV9hj_ZvzwFL
 WALmFSbSuEhO9u6E2C7Hz6r3843yPXPwMGWdNHPIjG_Ph2h4YiPVfrbLlRUqCvVe6p3HxNKEK20r
 HSxq5jEX2wMyd6_OUZxNkNOO0Ha9mHjKG7o83i14_VKp2DNrYRqr1mLyOX1lsIxPyFCTCU9OHoqb
 IGdji6WzjmXUZDcKLQF__uTbfGD.4Iv.mg.v9upmtfvzt0465RDaVOjHAgp3a6VdJgQsnTsqefAY
 W45GAYNihOV_al7snAGSTeYqJSLrsAgvQp8Pp.jQprnknSIvz.E2azjb._w_yOnfXdwuxSKz.10x
 ykjNa7JgiG_R.pEeASJpOWjnwJF_ebPAzeyvko.lauxbPmxrJrCfHDTzY.dTUQ.__.VpcianUcVO
 P150eAEZFMUv9217f.EW9Gf2tfoGI1QLdjmhPRiHFY4Umv7fQMzXY.iX5GeKknRV19pDe3sdRV12
 X2vtqd6QDnELp.U92QxP1E88lJtX5GScjS8zyxEWsux_XCztZJcJx.InbOnszZ4jmCzJMMEkbLgz
 S1tiLQgCkJHuZfa2hxKWv2zryrXZSbMxdO5ViiOAk5DretADJ6_WO3ukpY5S4wAKeiq40_2unDEX
 V2zGb7vJxFtijNW2O24KSDMkTnULTQ8HTWIV6bpSB8JslMXcExA1tM84xTtErUwEMxi2ZjvKZLsP
 B9aCQiE4Tb2mo8NockvD7NZfyJ4H1WtEB1Ve23WA6MB_3Dqec0OU.WmC6TnaH1TkrkjI4RaIhZhO
 3t0CV21A0hITeRavgo.vg3Cj9O_CxBHkAwmJM7fLJ7AxmUJoqimVvwy6S3Dg6o_YWbiabUiGmu.w
 V9NdprlfabrJx1B5j308ixFLtJgpIHMEc0yog1aAndtLDjAUeKr8Q9iqzR0r1.8.n11sp7C5bFDo
 C.RVslQu1syGK8U_ym4gaiAicJIGWBzSSDVnjl6T8K3IXndJeB.MfBt2p2sNCnuyi11WaL.oPX48
 2IoTRrUN3PB5t3NOw5sIZInI76X_TJaoVlFN5GQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Dec 2022 15:37:37 +0000
Received: by hermes--production-gq1-d898c4779-9jfqr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 88e0117bf245ea795b169282af69f581;
          Tue, 13 Dec 2022 15:37:34 +0000 (UTC)
Message-ID: <3e971295-fb0b-3426-6054-e3fa5307943a@schaufler-ca.com>
Date:   Tue, 13 Dec 2022 07:37:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>, Paul Moore <paul@paul-moore.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>, casey@schaufler-ca.com
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
 <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20926 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/13/2022 7:00 AM, Jeff Xu wrote:
> On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote:
>> On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
>>> From: Jeff Xu <jeffxu@google.com>
>>>
>>> The new security_memfd_create allows lsm to check flags of
>>> memfd_create.
>>>
>>> The security by default system (such as chromeos) can use this
>>> to implement system wide lsm to allow only non-executable memfd
>>> being created.
>>>
>>> Signed-off-by: Jeff Xu <jeffxu@google.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> ---
>>>  include/linux/lsm_hook_defs.h | 1 +
>>>  include/linux/lsm_hooks.h     | 4 ++++
>>>  include/linux/security.h      | 6 ++++++
>>>  mm/memfd.c                    | 5 +++++
>>>  security/security.c           | 5 +++++
>>>  5 files changed, 21 insertions(+)
>> We typically require at least one in-tree LSM implementation to
>> accompany a new LSM hook.  Beyond simply providing proof that the hook
>> has value, it helps provide a functional example both for reviewers as
>> well as future LSM implementations.  Also, while the BPF LSM is
>> definitely "in-tree", its nature is such that the actual
>> implementation lives out-of-tree; something like SELinux, AppArmor,
>> Smack, etc. are much more desirable from an in-tree example
>> perspective.
>>
> Thanks for the comments.
> Would that be OK if I add a new LSM in the kernel  to block executable
> memfd creation ?
> Alternatively,  it might be possible to add this into SELinux or
> landlock, it will be a larger change.

I expect you'll get other opinions, but I'd be happy with a small LSM
that does sophisticated memory fd controls. I also expect that the
SELinux crew would like to see a hook included there.

>
> Thanks
>
> Jeff
>
>
>> --
>> paul-moore.com

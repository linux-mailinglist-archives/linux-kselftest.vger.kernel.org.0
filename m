Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6665F59C905
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 21:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiHVTf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiHVTf1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 15:35:27 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3344BBE4
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661196925; bh=Q26bK30v0+l1Nw79b+fag9PLxrpXCMH32VCHkfZwcSY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jymCjf8QJC9UZltMr2hkPl2BMnqp9d+8hs8+gNOpYTOAWedX9KnrwENfIxrx+nz/Vg9qLbeVnn1hpV8BiGIunCS9OCLYR6kxBy1GrrxSpBh32NkWyQmJGRQ8OGrKV70K+w2cqXpQitWEJTC35zd3kAu45hB6JE+rycJK4cIDRsE90sW2Nf52OD66B0xXkNueeuzNRZehg1pA48+gX2JHOImB6CXPQqMlt5LQAw5HRhUt4C92IXwf8xCANw4x+57b0NS3bcUsrQHbeL4bFqWe1lxBAlK25Hu/+5+eS+ts7Ce0FL2a9ZHPIQu61jsVd/2rxay+pl+7wvx4iKrGfdMNFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661196925; bh=V68zN1hCyRtMVy0a2oPGqjYl1XmTHc25QT2qdBC33iH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hApYcbfNrxwx8HFvR0/s1SddQqK+kVx24wvHibp18UZqsZz9p96Z2DuN0Uwc674KB17K1oyrkhN4SnBNiyMRFQrFFqzB6hfDlkvxMLlS58VHNO7tCq6cxMl4JZkoAe7gPHeCWaaL3K3wPu78syH8iU4tq98KiTVmHiWeammaTreoXOowTJuU7u5HjuoQRN0b0Cx5aDNohbJcANnZ/uzMUHGJmgkp2InLZjrHfcz98Pa/p3QdKVUzY0neB6LtNMN9F51HSObmOhHjyo3/mTdrHuN/M+KAh+ojVXFwtHJ1xTSC0vLU5ikpX8GieuJvL/hwupSVW24ofh1E+Dc7A69vzw==
X-YMail-OSG: 2geRyf8VM1n1UjF8X9QBUBoBu7zk._gGtvw8WpT6nwTzEWfXYKdGmjJZ785zQ_6
 VpyfuAECxy.GmRwmqIOc66Yb9KiWWruA2G57hLOKNUDGxxO8sx8ntrvlftWg169jXr8cFDvGlupx
 edBAuGPCePs.fZz_xduXCVxV19TQ05IBMn9xSKta5NCQnG_OFet8YqT6vcUpOIAQDfggB.KToUH1
 pswZVKAuAa5tSzTxxjHsGqAl_ZV4S59i2xI1czL1f.87gh38TFMvwwSZQBgmfWzJ6YDuwwgZTNgz
 rN.YIf7ascNWdYSz_yyhvshWV.p4RZpx2vYa48E1U9WQOPcPjybxl60IHJ9s57cs8g6O8tPzjcjw
 VZ_YxTWOK1zG3GIAUj1qFtNcNKQs85NGRzp5wJmt_WOyHws6OmC0k9ug8otcWT2JdZanlReylpRq
 Q6y4_q3jzfAOOR2gkhtGqNq1MyK9leb7tvfhhwflYd8cZ55Phv1j3kua4wRbsjNAVOxf.iCRQ060
 zr0uZ6X4CYblC7VdtCrnrhvjzFWKR.5iIzEaFgwJQ26kQrRRqkn38KAn7BLOE28nFXLovNVcQARx
 f..5h3LmPzSBIlv76ct5nqLCLztFHg5rwIhRcwRqUO44hhYZTYZHcOoLyf2c6jj69t1vvxbz7Mx.
 m36lDF51Mv9j5t20.dPy4pSz5vOLPSusbxTwPXtNoXXIsN._6XfRO1l5YxPUm7xeUctTCwivhBCR
 mL4tgqQLPsw4CtLneaCvUjOODBX5RKaI3XPE3A8NnEUmKmjMcgX7c7IKElpCjWaVH64ZpP.gULTW
 h9h9nOqz1i6vlYxBU2LA.T0gQOgmGKNuLhGC_CDGu1m6OYYtiALsBYzOix.M_tjlUvotEH9.3F5B
 B3Tb.cPZcc660lkZWtfWeULsyYT7UZqJtK2q8h84QAipatZdhCcZl_.IzdOO3J3O4VIbQlm8fI4T
 XlV.frV9Rj.1DSgxpK_V0bFel11T3uRD1.GvLtf.dSM8T6IDJfpTm0E0xK3.xEhxHUXv57IfFjXJ
 345SWAdmj1y8USggGDqybq8s7Q7NGFQN6AyDBk7c4RHDT8ZE.5zAFoExdUOG9ixZ2rkPhv3g1O8H
 9wnQ9TTy5XEqs_En2qfSzJ4zmojzpAK0XJkNGvE9XDvPEZq5Pq7hDFehU65pOrpkFC9.uD51ZTLH
 2PNQbdjinVSM223OeJcly8wxjLsTqnHWADP50XINJPiX9JVW5E8eBPswjIcyrXBhdWW4zf3Z9KRe
 5TW0ibp8Pem4nPrtX2rW6SbbLQhUfCG9fnmqjs2pg33JZUF_myIbCm2Vm6L1.spMvbShtU4Dk__A
 r8fHMogM9OOQncIt0qYNLkBTaGVeTF_NovY6Xc__wdBhUmSUaTIjIhI5nKHU2phpD9Z2d7wClTmE
 AVL9hgrhKJiHr6i_3QvJadYnzix7JiG0a0mchwLXAK3kyoLIpeZ.Gemo_fTNC92KCzRw1tD2WxUR
 VJZbENSqxQdj9KrtO1uEp0x9tns3DIL9.9refZ3D735pktlNxmczNtUgYnI12gi4I32gHqjFL5E.
 82wxuvVE0shzIz5b.QTeNIpti5FRk88ohT7JcI7.nqrUFJjBnUCJaxACAxIpf.n46Oqtz3WoS4rt
 ALYlQ9IkfW.eHXvQdWfeN.t7zNQF5_2PzACQv7GB.yKsy6wMu2Bx7XJzzfyU6vZGWFlMpksBVvKA
 PCKAV8.ZO.k9cIyhOMIN2HTVV0mO9cTzqAUW_ifWdBbA8WNoTpBc6J7wZkGE7qwozjsqUG4Mgevm
 7jQvSm3ba4whfnBFN2_lHGCoGcF1UeHlQbmyi8weX0QGiaZzGsuenlI8GbnNOe0kwRXbQaI7DwzE
 j8ZUfHEfUJ6roB9OLQh6F6285QTLr2s5zYff1zBWXpOiNdscMp3KRKNljHWxRM2w_ozBBPILDrPQ
 aFKhOclcIfqO2iGZpisV5V1knl4WRO0qFPqbdEUdi8Rq413q1BOGqJIjaCGp_pFZ6zqB.FaLHGdX
 3SDiUoVtWUNhO_Abpt_eTdQ0I2IKbRdBrgFloxO4wLe_RWmU96As0j0SNOyZJr5pvXLsH5SH_l8b
 OA3PvT0cr06NESF__rAaCHm_E_YF6H2AFj.qjp1IFzOx25QigLW9JjBs6ULkjNBKrQaiOih6aSbs
 97J5PTgFFgMYvht1QNtQlzcJernM.HaQJfLEfPBLCS7mrneR_QzvJckMbKAXcyWGjWUhaiuHJwSO
 RSseE8qmHBBHSoqbjp.EDN96kqbRsT3jR1xNDj7kHi0FT6d7etjOfI38i5yDz1RRLSR7zi0onutn
 FCuU8LS3QCkLJr5kM
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Aug 2022 19:35:25 +0000
Received: by hermes--production-ne1-6649c47445-8bqp2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82d6845c125ac4d2c128f4140d2d784d;
          Mon, 22 Aug 2022 19:35:19 +0000 (UTC)
Message-ID: <39df1a34-51dc-da55-ff1c-59cab896c8a0@schaufler-ca.com>
Date:   Mon, 22 Aug 2022 12:35:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 0/5] landlock: add chmod and chown support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, casey@schaufler-ca.com
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <YwPWN/d15S24PuLS@nuc>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <YwPWN/d15S24PuLS@nuc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/22/2022 12:17 PM, Günther Noack wrote:
> Hi!
>
> Very exciting to see! Thank you for sending this! :)
>
> I'm just throwing in some comments based on the very similar truncate
> patch set, in the hope that it helps. (But obviously, Mickaël Salaün
> has the last word on this code.)
>
> Slightly higher level question: Should we start to group the
> functionality of multiple LSM hooks under one Landlock flag? (Will it
> be harder to change the LSM hook interface in the future if we
> continue to add one flag per hook? Or is this structure already
> exposed to userspace by other LSMs?)

I'm not a landlock expert. The question is nonsensical, yet somewhat
frightening nonetheless. Could you put just a touch more context into
what you're asking for?

> For example, some of the "missing" operations listed on the Landlock
> documentation could also be grouped roughly as:
>
> Modifying files:
>  - truncate
>
> Modifying file metadata:
>  - chmod
>  - chown
>  - setxattr
>  - utime
>
> Observing files (check presence and file metadata):
>  - access
>  - stat
>  - readlink, following links (can observe symlink presence)
>  - chdir (can observe dir presence and 'x' attribute)
>
> Ungrouped:
>  - flock
>  - ioctl
>  - fcntl
>
> Do you have opinions on this?
>
> —Günther
>
> On Mon, Aug 22, 2022 at 07:46:56PM +0800, Xiu Jianfeng wrote:
>> hi,
>>   this patchset adds chmod and chown support for landlock
>>
>> Xiu Jianfeng (5):
>>   landlock: expand access_mask_t to u32 type
>>   landlock: add chmod and chown support
>>   landlock/selftests: add selftests for chmod and chown
>>   landlock/samples: add chmod and chown support
>>   landlock: update chmod and chown support in document
>>
>>  Documentation/userspace-api/landlock.rst     |   8 +-
>>  include/uapi/linux/landlock.h                |   8 +-
>>  samples/landlock/sandboxer.c                 |  12 +-
>>  security/landlock/fs.c                       |  16 +-
>>  security/landlock/limits.h                   |   2 +-
>>  security/landlock/ruleset.h                  |   2 +-
>>  security/landlock/syscalls.c                 |   2 +-
>>  tools/testing/selftests/landlock/base_test.c |   2 +-
>>  tools/testing/selftests/landlock/fs_test.c   | 234 ++++++++++++++++++-
>>  9 files changed, 274 insertions(+), 12 deletions(-)
>>
>> --
>> 2.17.1
>>
> --

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9776B7EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjHAOqY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjHAOqX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 10:46:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8D8122;
        Tue,  1 Aug 2023 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690901178; bh=2Q9UftFunqI8BGbgAwN1QAXz5LdKJUNCvUkRCd/pZhY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Q3h2Su0VxqQvzGti73jpgoVtiYj83o1MzxNBHF5+HedLbT/zSaRZ6kqNKhrBD7mBD
         Q7YWf/fNM6Gnvzl+soSMQETsKoiR6jBaTUMNJcH9B/VIqVol0ZEfKU0UZScIo7dSHQ
         jOG52B+hTys2ZVjfRolg4t3HHMOdFmBZi+2yyfso=
Date:   Tue, 1 Aug 2023 16:46:05 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Message-ID: <77ed5175-73f3-4751-b95b-353ee9b73331@t-8ch.de>
In-Reply-To: <CEF9B5A6B5C43FBB+a5f21a530c1baf5229614c8186043e223b9d111f.camel@tinylab.org>
References: <cover.1690733545.git.tanyuan@tinylab.org> <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org> <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de> <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org> <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de> <D55D0905148FA2ED+f06092bae15b312ff1b29ad170fb656b89722b30.camel@tinylab.org> <51b39ee9-7645-4759-9cc0-3cfe721a2757@t-8ch.de> <2ADAE3198D1A85E3+c1c957d4706ee51d90e0b2a425a633eafcca8810.camel@tinylab.org> <413f70e4-245e-474a-9293-05068fd2eeb5@t-8ch.de> <CEF9B5A6B5C43FBB+a5f21a530c1baf5229614c8186043e223b9d111f.camel@tinylab.org>
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <77ed5175-73f3-4751-b95b-353ee9b73331@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Aug 1, 2023 14:23:22 Yuan Tan <tanyuan@tinylab.org>:

>>> Would this be fine?
>>>
>>> static int test_pipe(void)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *const msg =
=3D "hello, nolibc";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int pipefd[2];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char buf[32];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t len;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pipe(pipefd) =3D=3D=
 -1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0write(pipefd[1], msg, s=
trlen(msg));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0close(pipefd[1]);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D read(pipefd[0],=
 buf, sizeof(buf));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0close(pipefd[0]);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len !=3D strlen(msg=
))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !!memcmp(buf, ms=
g, len);
>>> }
>>
>> Looks good!
>>
>> The return value of write() could also be validated but given we
>> validate the return value from read() it shouldn't make a difference.
>>
>> (Also the manual manipulation of "buf" is gone that necessitated the
>> check in v1 of the series)
>>
>
> I am sorry that I didn't catch your last sentence.
>
> Did you mean this piece of code does not need any further modifications
> right?

Yes, for me this is great!
Sorry for being unclear.

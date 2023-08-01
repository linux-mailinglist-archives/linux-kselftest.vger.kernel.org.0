Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3976B8E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjHAPnF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHAPnE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:43:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21906A1;
        Tue,  1 Aug 2023 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690904581; bh=CzBUmhns/eo2k+tTHnvM/cGSmZodzPhkH794ch/eTZs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FhwxZ7xkm/yLVz9K96+U/33bWCHht1reYDLCjSU+JaHS89BJXM7It9obJTCMIsILn
         uuSmlumeNGJVYGfLETew0QsFFyVvJbvlqSnil/lcWzE0BKZ1gghAdeWtrKYjanPAlZ
         IQGYD3PhSQ8iQJfrXy769uv3lRo9EkJTXOL+sTbU=
Date:   Tue, 1 Aug 2023 17:42:57 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Message-ID: <d8591760-8a00-4837-bc4b-21418ac7a5d6@t-8ch.de>
In-Reply-To: <cover.1690903601.git.tanyuan@tinylab.org>
References: <cover.1690903601.git.tanyuan@tinylab.org>
Subject: Re: [PATCH v3 0/2] tools/nolibc: add pipe(), pipe2() and their
 testcase
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d8591760-8a00-4837-bc4b-21418ac7a5d6@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Aug 1, 2023 17:40:01 Yuan Tan <tanyuan@tinylab.org>:

> Hi Willy and Thomas,
>
> In v3, I have fixed all the problems you mentioned.
>
> Welcome any other suggestion.
>
> ---
> Changes in v3:
> - Fix the missing return
> - Fix __NR_pipe to __NR_pipe2
> - Fix the missing static
> - Test case works in one process
> - Link to v2:
> =C2=A0 https://lore.kernel.org/all/cover.1690733545.git.tanyuan@tinylab.o=
rg
>
> Changes in v2:
> - Use sys_pipe2 to implement the pipe()
> - Use memcmp() instead of strcmp()
> - Link to v1:
> =C2=A0 https://lore.kernel.org/all/cover.1690307717.git.tanyuan@tinylab.o=
rg
>
> ---
> Yuan Tan (2):
> =C2=A0 tools/nolibc: add pipe() and pipe2() support
> =C2=A0 selftests/nolibc: add testcase for pipe
>
> tools/include/nolibc/sys.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++=
++++++++++++++
> tools/testing/selftests/nolibc/nolibc-test.c | 22 ++++++++++++++++++
> 2 files changed, 46 insertions(+)

For the full series:

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Thanks!

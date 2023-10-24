Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895C77D577F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjJXQKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjJXQKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 12:10:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652383;
        Tue, 24 Oct 2023 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698163817; bh=BGpGXa2le8JndayrpdMF4iQUDz4daWsh8s0cPrtB72I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ICCzYNDRGQwF9QhydliHxDt5L9j/Iigbw7rF2/9gYCgKRkj6mG3TKDqyMlGu/QVnr
         W4V1dC8BvhL4B+MAr0yA5NOOKLQUguM28eGBlZXnFu1PPsPVmcVg2WbwHzd5ewiOB1
         reCg/zrTIf9clY1sVTcg8onudIXQg3W3x/s4Id3Q=
Date:   Tue, 24 Oct 2023 18:09:59 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <2fc4054a-ab4f-40c8-b378-1423751031f5@t-8ch.de>
In-Reply-To: <20231022093117.GE2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net> <20231010-nolibc-out-of-tree-v1-4-b6a263859596@weissschuh.net> <20231022093117.GE2669@1wt.eu>
Subject: Re: [PATCH 4/5] selftests/nolibc: support out-of-tree builds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <2fc4054a-ab4f-40c8-b378-1423751031f5@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Oct 22, 2023 11:31:32 Willy Tarreau <w@1wt.eu>:

> On Tue, Oct 10, 2023 at 02:33:59PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> Out of tree builds are much more convenient when building for multiple
>> architectures or configurations in parallel.
>>
>> Only absolute O=3D parameters are supported as Makefile.include will
>> always resolve relative paths in relation to $(srctree) instead of the
>> current directory.
>>
>> Add a call to "make outputmakefile" to verify that the sourcetree is
>> clean.
>
> At first this worried me, I thought you meant clean in the git meaning,
> but it's clean as in "make clean" from what I'm seeing. Yeah that sounds
> reasonable.
>
>> This is based on Zhangjins out-of-tree patch.
>> It extends that work for get_init_cpio support and also drops relative
>> O=3D specifications explicitly.
>
> Yeah I remember these discussions about these shortcomings, that's
> pretty reasonable.
>
>> Link: https://lore.kernel.org/lkml/06d96bd81fe812a9718098a383678ad3beba9=
8b1.1691215074.git.falcon@tinylab.org/
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> (...)
>
> I think you should add a Suggested-by at least since Zhangjin attempted
> that work quite a few times already and allowed to make progress in that
> direction (maybe even co-developed, I'm not sure).

Indeed. For a proper Co-developed-by I also need
a Signed-off-by by Zhangjin.

Zhangjin, are you fine with giving me one for this
patch?

> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!

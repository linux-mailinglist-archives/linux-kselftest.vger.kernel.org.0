Return-Path: <linux-kselftest+bounces-25820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B080EA289E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC7165A55
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FD22B8B4;
	Wed,  5 Feb 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="BpeyaPLp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021142288C3;
	Wed,  5 Feb 2025 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757286; cv=none; b=h0GpfDPIzgZ3A8cIfezmMzFssN5AHUc7nXGShewaiuVESXii423MS4maFtw1+Ww6v/9+Rm3PL8f6rW7FFnLirs7f4KpODr8oRwFezyH7bKVen+AkHcGNIUnB1rRr53LgK5wSaDfTUBJQdQu58LQrl8PWtT5QNi79vdvujE+34xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757286; c=relaxed/simple;
	bh=hfOBDidveBTY5zG6q4eRED2kIwrb6Se/qe+DdGfkJtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7k7bKBHprsDGQBKvrV/ie4dOIQD+oA2ULAVPg0dBC9YovXl+FRHdBrUzo0g8lFWi0KjGygDTPq989nfbwKWJCEnA76D5cLjpQ54RiC3v3dOlf3UE9VspNtmEynW8XM0tjd0q4OJm0smrGR/tI1R+ccpF7Lt5bZrJ0LkLOrpKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=BpeyaPLp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738757277; x=1739362077; i=ps.report@gmx.net;
	bh=NRji2I5Kps2UTT9YGrQPdJ+o5YPpjrq/OOrhdIkPcpI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BpeyaPLp63Co5cS6184vpC8Y7BYZ71/HKR1ZYD1W8diT216obkAz02VhWHQnYbIK
	 fbwLzT1/HwvH5/KrXlXrmSUzHDzhhvwFcmM5wUaBg1bEMj1SEjEZphWSfCTfBzH3e
	 UHREi4f3jRfNsB33JXgPniiQPH6BPIvnRIcqyfnAEilqtr9OPhInrprOBEz9LRB30
	 CnpVQehysqcn1uA12YUhAVJEdMufwt07wCxedpzt7tUCKOt94HpBIS9ImEjfLszXn
	 MSvCPs0uHZ3Lz21tF9OlFpVodxF/MorTOj3RTvuV7uxewbgxpRl2px3xhX+bEohbn
	 bUYuO21/L5kTupwl6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1tOOIE1LUt-011skk; Wed, 05
 Feb 2025 13:07:57 +0100
Date: Wed, 5 Feb 2025 13:07:56 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: shuah@kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests: pidfd: Fix compiling errors and warning
Message-ID: <20250205130756.7b7b4f7e@gmx.net>
In-Reply-To: <20250205053926.257732-1-richard120310@gmail.com>
References: <20250205053926.257732-1-richard120310@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Exxcw6iELtCi9TnG1flstflGYhS/N4hyln0Rl1gIISb//sMxT5j
 Uq/2BBjzPqlOznB7N10EJDTk1tZniEBwa7cyGJczAF/iOzj/Pyr3i5NDnCZLLI7dN6/v9oz
 3Mbhp7+rdmXS4lDWqJPfIlSwSVRas+lqaLMwQLN7/s6+LmeKb2qgDB8QwN5yP6l4EF+134N
 37uYmbwTpZ1dPuiuhXWHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gw8Ya+WnDi0=;x6L06RkvVciT8l9AXZX2yCXYmnX
 pjXU9I4x+m5bWstXASaMyOOhUv4mvM/5SGfR2TMiLQWSM0MT+wRLx6HO2bLojNnTHzID9HwTK
 ZayXC3WEqfS4H37rxvcRkMzSuoHY8p2npCHHc+1TpMgP2ezuqhc+zRHNjqd0TDCxGcYutFf4+
 0xVks2+QH7TAlkAFMRLNzHFTy8T86HPqrgzQ52HcNEc3w2YimjtNIqVEaSHB8uELpTy1JmtxC
 7fj5ZYR/wmcuowZmuzEAvwYlJ+VnbJ+R0x1oBcYjpAlxIUUgYHmOyVBcM39zUvsxWs9YnIG1m
 XfyTywUy1o67B6Tqk3k2LoffLAskD2KrUr/yod2onltQYsztaX6M+/TULFH+fDXKzbgfTOy4/
 tFMcOPRoLrTZWY/RsqU/WkAb1W+RUAshyPEHH7np5HUzdIUEKWZZZuJJB/YVCQ1w2YIYkfiA5
 HVddXAQduJskh70WvTceGnZTTXLxRJqnjEONF22yXqAuO+8EQNEE7UaLH5WhqSmbh/vi12UsU
 MiGJUghRPPJ4A8C4lcY6DYiZgw/+uJfL64B/5/CqBmWW6+q8Zml8YRzGOMF+rJA2RQDBMXlcj
 GBycdjR5ugn0kCJoQ0UER5Y0hgc698lkNi1wYbph3kBsvL+J+sKo7MY4eTXzl2GViy7DkelSc
 3tUq0VZMuvZ+G69h8iQUvcSv92R1mphvvF5kfK8yMu2ARpAQgsyG1vGIen+3NnqzPXx9fhJGS
 0CGOox8y9Dgl0nO222fLcTf5rUltai/oxlJeyCKyn0TiqOMVrFbWBRmJIJ+m6yY8cZy7fV59C
 2bGypAEWksylKIDs21+HuaWiaKIbqxt06GWu0+ORAZl+Rc32kkTlkVqGoAhgdLZOIiLfveRQ8
 oa47koQSdLt+QJ5JxT2rnF20JxHMe1OGvdQMiSG15AhP91ZvKGqmNl3GNp8jIaeLnjVz70Z4Q
 0sE/L053pN/6N/MWA3cL/xCSTifzAae4i2CQd/X82Xze5cDeCj4/ls2l3bA63Yg2IhDX6GdLq
 +c5paLkFddA0R9ci/7Qtcxw9vP9idQV5W5oGxNvSW65GrPdiw4y4vynXiBUJayb4ONFQS1AH5
 gNLYXhCZ6zn6HkTDd9geIHItq/mlZOI5fFpB/AT+tbsfsXdrvVV3FMds9+0Wz+fI8JILGmgG6
 dsV8L0NnscJdzQieQZ9s1wg4sIs8joe77XTAtrQjNwhljpu6tDdwQEAZcZdsFbZXFySj9UzNm
 ej8ilgG4SkYcSAxZ/E028StzaJEHS/0xpiy5APyRLw4C0uUeirCKSb36YDx1nQcyfgjqRBrP9
 tsodW7OGIjduhtqY7e4QToHcw==

Hello *,

On Wed,  5 Feb 2025 13:39:26 +0800, I Hsin Cheng <richard120310@gmail.com> =
wrote:

> When compiling selftests files under tools/testing/selftests/pidfd/ ,
> some compiling errors and warnings will pop out as the following.
>=20
>   CC       pidfd_fdinfo_test
> pidfd_fdinfo_test.c: In function =E2=80=98child_fdinfo_nspid_test=E2=80=
=99:
> pidfd_fdinfo_test.c:231:13: warning: implicit declaration of function \
> =E2=80=98mount=E2=80=99 [-Wimplicit-function-declaration]
>   231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>       |             ^~~~~
> pidfd_fdinfo_test.c:231:36: error: =E2=80=98MS_REC=E2=80=99 undeclared \
> (first use in this function)
>   231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>       |                                    ^~~~~~
> pidfd_fdinfo_test.c:231:36: note: each undeclared identifier is \
> reported only once for each function it appears in
> pidfd_fdinfo_test.c:231:45: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclare=
d \
> (first use in this function); did you mean =E2=80=98MAP_PRIVATE=E2=80=99?
>   231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>       |                                             ^~~~~~~~~~
>       |                                             MAP_PRIVATE
> pidfd_fdinfo_test.c:237:15: warning: implicit declaration of function \
> =E2=80=98umount2=E2=80=99; did you mean =E2=80=98SYS_umount2=E2=80=99? \
> [-Wimplicit-function-declaration]
>   237 |         (void)umount2("/proc", MNT_DETACH);
>       |               ^~~~~~~
>       |               SYS_umount2
> pidfd_fdinfo_test.c:237:32: error: =E2=80=98MNT_DETACH=E2=80=99 undeclare=
d \
> (first use in this function)
>   237 |         (void)umount2("/proc", MNT_DETACH);
>       |                                ^~~~~~~~~~
> make: *** [../lib.mk:222: \
> ~/linux/tools/testing/selftests/pidfd/pidfd_fdinfo_test] Error 1
>=20
> Solve these errors and warnings by including header file <sys/mount.h>.
>=20
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/te=
sting/selftests/pidfd/pidfd_fdinfo_test.c
> index f062a986e..f718aac75 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -13,6 +13,7 @@
>  #include <syscall.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
> =20
>  #include "pidfd.h"
>  #include "../kselftest.h"

Predated patch already available, see

	https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps.report@=
gmx.net/

Regards,
Peter



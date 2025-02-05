Return-Path: <linux-kselftest+bounces-25821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6CA289EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6CD166EA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B622B8CF;
	Wed,  5 Feb 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="W1FkzNF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3422B8B6;
	Wed,  5 Feb 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757373; cv=none; b=uh7Goj1rcsu4l9qwMLdvvxNzsdy1XT2h1GmjTCHscfvWk+VHW1sNI0HQty1mo0ehViaFgXViOXLnIQPetzoLsN/H+ZIkR4S7h35AYgsyMVJw1fd6i2PpyEgAzWQrEzKyrLPNtElJ+QJuFePUEGgbWeb56gvaiU478VGOmtxKX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757373; c=relaxed/simple;
	bh=aV2PT2ZWUXires+2k4JBLhOJuhQtJ4KlbgLJI7iKoNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD143FUzJGooKy5Te/DXOyL6MoNnnaqQjXPoE8GF50Z+Tvl+ve2yoV6xLOuebFAs0yYFQY0OE0GUs8aI1UGOBp++ppTSycz6ncNiat17WaF/3AVx/GXpTPG+Ytut138Tcms7vor4Nb3OgBiZZ7gdChw2LDmNjWidwMyx8J/LyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=W1FkzNF3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738757362; x=1739362162; i=ps.report@gmx.net;
	bh=5Ly310pRw4VvwxO8ViwTJZkXUc0ccrejTROPbkFRmdk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W1FkzNF3wZg687JDp9JeHDl5UI2Q9PvH1PbpN8F6BwHOgd/n6tno9CwzE5mpycgt
	 e5IGmuypvzIzxBH20ZGskcUG6fV0PRGf77CvA651q0lCcZIvEooTrog9jXYfK9mUu
	 ks6SJogoBCnfEIM95NUmUEuDwkXFjaKCtSdJs2rZBwfe8dFD1RBIl9OEurK9yYNL4
	 HCVW5TrxUzchDB/W3qbNliJ1qryaumCATrLdZfHgXqOzHm4FepvxFmvgL7cCada0G
	 UZr/MBPZna1Vv5zNC0h/Mlh69i35B52kK4dZKm+V/Q/ArEfsHmmN5TXYqDnrobOkW
	 oLaXfjUb6mGHae+LIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1syuwA0aGq-00cHzb; Wed, 05
 Feb 2025 13:09:22 +0100
Date: Wed, 5 Feb 2025 13:09:21 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: shuah@kernel.org, brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests: pidfd: Fix compiling warning of pidfs_setns
Message-ID: <20250205130921.137aab7a@gmx.net>
In-Reply-To: <20250205055031.259710-1-richard120310@gmail.com>
References: <20250205055031.259710-1-richard120310@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zh4QcND3OhVSbDjJlrCRXEpzfFhi9oUFwtnon7+rXl4IL/CD9nN
 bCsG2sWT3L3optJVlb78GkplX7TUWvOgjFBRSO4PRF6pvKkYZ2wXzWXCL5oELHKjgVBv4s9
 s2GNXQpNyntu6RIUPHYXp7zt9+J0qKX5Vetr1Lti8kS2PXkA24kFgGFhGAwMPv2WblhnJbS
 NcTkRKDSaewN2QD9jILMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nkwF0ENKBuk=;zEC+ZXsdZyfKk3EXWWj+HFLfML5
 FL6dHh41XdqsruXcbf+LMcn1fckG7TxWPf1GbkwA3C3tJCNzxaET161YDQRV8eiGRkT/ZBeQM
 PzeK+vkUOtLpibsbCB1mWICsCUN62bwsb3RvXiIsWD9kYkuOjMyLqmIvb4GrMroUeXE/pTN/z
 jjuYUDdQQcooFJrBW7+lAl7477QiHLI8Quaagfp7o/CRnWSNmzirwN1BslMbKHISeECuUwgkL
 +vxC57lOJAkRESD6R178FdbzwAiYT4zBKBAlfJMr0J/H6iMAvRo96jaAO7cXeny7T1AA53G3Z
 jU75EeYg1T8zDBjQO+leB0CYMnZ5BN/7hfM4fkxew4euEYbLEckZNIZO2uZ40qFcdHABGAdO2
 YQGeudGBSNUbuxCJTzFhQeiNPCdSSf6PvjagsmWvHhhzBdWfVbxLexSQEmcT8IU7PgeQdWjE4
 IGpP+P6jwC7nnMe+Ez9NsvxukDT7mQaUc+T3IIx2scosTV9S9wsRx7xcA9eJ4/X0WlwW/hDbr
 TSeKQDVo7DLh06OrekK9R1+3Iu8C9xcvvoIRdv1U+fS4VZf4QMHevhhGD+Ff/1ZY3Od/KfAtc
 l61IBoklJMNmApIwc/If9nG5z7FuYuBmKQyyqbsSI6le9MXTzW6/dm1SeCVW6V+zw/JE58oad
 4cxjXguCucSCHyEkkOgDUB2B/immLiZQpHiijWcUps1p/pUxFr0JrEXWPKE2bl9aILLzkQPWR
 VLCnFoVhNRHnatAKPUoMTDDpsPYbtYRydasmWZjaX2oVDdidp1t5LoMlGeLlupTBkop/Xghny
 JjF8ye5S5siEVojUgXtajM3jeHof9LsEe66TsqxhVFWt+UxKIwa/veX7mNhWtb1LHyANNogAE
 JGzykPJfEgdoB9GxFJP/kD321J4FaKJda9G18+HPxiHXu+6bHwZnCY5Sq39y+v1jgpHt6ZjR4
 p4UCkJjgJT58SGlvTW2lg+67YevYWQiPZ7rDOdDpCxuy1SHzdrFBBW9BGFc/ws5DxQdSpuy4B
 XTBrWE54rkZ35vmtqRM6n5c3mwakY5JVlqzknB+EQysR6ir5OmZwNb6UNeJ+Z9xd7mchOw1/d
 d4AgPGxGJ+yN+q637G8dM+1PmoALFnWH13F7elFmGPVZVz9JazoKtMJTVHP2C8luRp0WSdnFo
 oxft+NfJZF83gqDuYks7Iyf70ZCLyR98gR5eT2r/aRQwG/l5Fl9+keUelGRCS2WkB28ycRGgz
 wWHhoK51ItS0A7cttaN++Oqru7CkeoXJJY73Kegx3IaP2x7VHKEJ67COPgeuMbq8NDuUTrEIg
 brErLTpvYbDf1Ok1fRCiBh0iA==

Hello *,

On Wed,  5 Feb 2025 13:50:31 +0800, I Hsin Cheng <richard120310@gmail.com> =
wrote:

> In the compilation of pidfs_setns_test.c , a warning as the following
> will pop out.
>=20
> pidfd_setns_test.c: In function =E2=80=98current_nsset_setup=E2=80=99:
> pidfd_setns_test.c:173:54: warning: implicit declaration of function \
> =E2=80=98ioctl=E2=80=99 [-Wimplicit-function-declaration]
>   173 |                 self->child_pidfd_derived_nsfds[i] =3D \
> ioctl(self->pidfd, info->pidfd_ioctl, 0);
>=20
> It's caused by wrong import of header file <linux/ioctl.h>, fix it to
> <sys/ioctl.h>.
>=20
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/tes=
ting/selftests/pidfd/pidfd_setns_test.c
> index 7c2a43491..3ed42f1eb 100644
> --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> @@ -16,7 +16,7 @@
>  #include <unistd.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> -#include <linux/ioctl.h>
> +#include <sys/ioctl.h>
> =20
>  #include "pidfd.h"
>  #include "../clone3/clone3_selftests.h"

Predated patch already available, see

	https://lore.kernel.org/linux-kselftest/20250115105211.390370-2-ps.report@=
gmx.net/

Regards,
Peter


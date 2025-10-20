Return-Path: <linux-kselftest+bounces-43541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5452BF00C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E5B3BBC6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6282ECE9F;
	Mon, 20 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PQ/pB4pm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794741643B;
	Mon, 20 Oct 2025 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950511; cv=none; b=eAxs7oODDHFHvTKVUOEAOodcp94ZOib9lW40jvkQRgWrbmGL3y4uJtUlU7FTkRkZP/IZPvO6VRBFrMHxWL9LxgNBF9t6t11N9mDUTFMCRRwD3SWZ6moGSU5sWtd7hQQAMVqkG1Iw8TO4/EAv/3ZNEEib6465NPK0GqOsZaCYvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950511; c=relaxed/simple;
	bh=wU69FWg0HnxDv6ekq3BFRwg1waREh/mUKaxeSy9S7QU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=W111cHSAWZ39GC/eLPwM0mqdqwp3nrGHLeoR58zDC/HfJheUPDRoMQMoS/RLQoPOr1RjuO+Hct8VE4iT8/I0ygiksztMgvNeCP3bBkQhCn6vkdJz8s25CWghnYT68pqAA4BAzgMhoKXcD2dIL+k15FJacm121PRtqNPMbyksSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PQ/pB4pm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ADBFF1A1533;
	Mon, 20 Oct 2025 08:55:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8243D606D5;
	Mon, 20 Oct 2025 08:55:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D53C102F23A9;
	Mon, 20 Oct 2025 10:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760950495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wU69FWg0HnxDv6ekq3BFRwg1waREh/mUKaxeSy9S7QU=;
	b=PQ/pB4pmgNCRHVAktZEPxdSjsFln8znIep9nVHYg0FN3yjap5mnMRj7EN0NH0KYjolciuP
	p/xR3bUJDhAwNc2gFTfPwedGqaUA67zh09BL9bffEXWZ1D/T078oTOhwNuHqKMJE+ohmAB
	Kd0f/pR2Ac4wTl3uY0wt+1H6x7eJ/BsEzDZ0F3cA895sAvfj5SvK6PwdxGgQuKmTynKgQx
	9lTRvAwCa/2VEGnemb+143wjJDRJWFOm8UETAh29tJsKilPKyrVI2ZqO+wPCWtPgyFmB4X
	b9RlL4FfH94f41DzhKL4IosQVLP8I3I4YdPHzaiVT+Mi3RJjYnB8clyIgg++6w==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 10:54:40 +0200
Message-Id: <DDN0UIQ05A22.1SDXOW1K83VYY@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: add tc helpers
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
 <20251017-tc_tunnel-v1-2-2d86808d86b2@bootlin.com>
 <a49ebaad-cc79-4ade-aa4a-ad37fcf81dee@linux.dev>
In-Reply-To: <a49ebaad-cc79-4ade-aa4a-ad37fcf81dee@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Oct 18, 2025 at 1:26 AM CEST, Martin KaFai Lau wrote:
>
>
> On 10/17/25 7:29 AM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> diff --git a/tools/testing/selftests/bpf/tc_helpers.c b/tools/testing/se=
lftests/bpf/tc_helpers.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..d668e10e3ebad8f8e04862f5=
c2b3ccd487fe8fa6
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/tc_helpers.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#define _GNU_SOURCE
>> +
>> +#include <net/if.h>
>> +#include "tc_helpers.h"
>> +#include "test_progs.h"
>> +
>> +static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)
>
> This one looks good but change it to "int tc_prog_attach(const char=20
> *dev, int ingress_fd, int egress_fd)". Remove static. Take "const char=20
> *dev" as the arg. Add it to network_helpers.[ch] instead of creating a=20
> new source file.

Nice, thanks for the hint, I missed this header

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



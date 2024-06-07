Return-Path: <linux-kselftest+bounces-11450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890B900DA5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3611F23B63
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176DF1553BD;
	Fri,  7 Jun 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="R5iMop9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1361553B4;
	Fri,  7 Jun 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796519; cv=none; b=G671bl1a3/q1+NxWxdIQ5Iu7BpYoNOdai5EEdiPXLfq+j/M00A1hG7CafZxrTOsXBJWegctXYUfIA2opQpdP3Uvur75u89wYElrIpzpcU9GbjP2O8Yfy8qLVU9u9ZQUO8zY8diVRumjMvtQZYBijZBcKFauLH45BkIFfBMgc9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796519; c=relaxed/simple;
	bh=OuA/cNeJGIxEaUjitR2IhUcrlBfny5ZFFd/ayhWbT8I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnOA6fMWbB4kjG9Ppwb5CrTgIRpCtPoLx3KeKQXgQEgosGr4lv2+7Ov+D/y5uzZ8YQUTR6iQ4lMMgjiD+FquEAA4y2MXNsTjKh23qqtAzzgo4YZ22nHJ0TB2nJI3LqnzMpLyL5TD+zx9ZCam/6upFkp7VMdgNKxT0N+fGaiMp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=R5iMop9D; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1717796514; x=1718055714;
	bh=XyoIRaw4nzp+JTQlueWeFgCFHVypWtZ2IYQLlnxgLXo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R5iMop9DHW7Ownvb2JoktckLjiBLCA+aAtm4fsxpZ/bO/K0f4OjumvLQl1n7EcoA7
	 ahhxO88lOIOqQRJMNnTomfsxxCQs7R+d3PpyGLUF01TgylAOyCgGTvB7IR6vt+RBrW
	 brbknFztOOOPYRR0xxkoO+TUCtodh3Bf0MCk3NO+h5Y/ULlrPYV7vjJHmQKNPBhIrt
	 U+l9HYibXjl0t5ZOPqlPDq46CHUIwtW2aHU5/CoksPmJ1aiLZJ/BbomOkZHMu0h8yi
	 PtViuhLrX0jxnhvvdFW8nfIk49z2RrLIlbb/WFfn8h2DPHK+PZ3f/Qnk/bddQG2mtL
	 U819ZdQNvzspg==
Date: Fri, 07 Jun 2024 21:41:51 +0000
To: jeffxu@chromium.org
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, skhan@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
Message-ID: <ERhTlU0qgh7_BDdbPy2XWV0pYgJkVYImFQZVPIfvx9F9uyhfaopo8FMZa8WZ9Txx1bzq8qEez4QQ8sOQIwKeQEdn1rym1JgDmvG3zOKdpeQ=@protonmail.com>
In-Reply-To: <20240607203543.2151433-1-jeffxu@google.com>
References: <20240607203543.2151433-1-jeffxu@google.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 7824bcd3ec0219abcc9292ba531faca6c127f3cf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi


2024. j=C3=BAnius 7., p=C3=A9ntek 22:35 keltez=C3=A9ssel, jeffxu@chromium.o=
rg <jeffxu@chromium.org> =C3=ADrta:

> From: Jeff Xu <jeffxu@chromium.org>
>=20
> When MFD_NOEXEC_SEAL was introduced, there was one big mistake: it
> didn't have proper documentation. This led to a lot of confusion,
> especially about whether or not memfd created with the MFD_NOEXEC_SEAL
> flag is sealable. Before MFD_NOEXEC_SEAL, memfd had to explicitly set
> MFD_ALLOW_SEALING to be sealable, so it's a fair question.
>=20
> As one might have noticed, unlike other flags in memfd_create,
> MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
> is to make it easier to use memfd in the most common way, which is
> NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING. This works with sysctl
> vm.noexec to help existing applications move to a more secure way of
> using memfd.
>=20
> Proposals have been made to put MFD_NOEXEC_SEAL non-sealable, unless
> MFD_ALLOW_SEALING is set, to be consistent with other flags [1] [2],
> Those are based on the viewpoint that each flag is an atomic unit,
> which is a reasonable assumption. However, MFD_NOEXEC_SEAL was
> designed with the intent of promoting the most secure method of using
> memfd, therefore a combination of multiple functionalities into one
> bit.
>=20
> Furthermore, the MFD_NOEXEC_SEAL has been added for more than one
> year, and multiple applications and distributions have backported and
> utilized it. Altering ABI now presents a degree of risk and may lead
> to disruption.

I feel compelled to mention again that based on my investigation the risk i=
s
minimal. Not to mention that it can easily be reverted if need be.

In my view, it is better to fix the inconsistency than to document it. I wo=
uld
argue that "`MFD_ALLOW_SEALING` is needed to enable sealing except that XYZ=
"
is unintuitive and confusing for a non-significant amount of people.

In conclusion, I think it would be unfortunate if the inconsistency was not=
 fixed and
the problem was considered "solved" by a passing mention in the documentati=
on.


Regards,
Barnab=C3=A1s P=C5=91cze

>=20
> MFD_NOEXEC_SEAL is a new flag, and applications must change their code
> to use it. There is no backward compatibility problem.
>=20
> When sysctl vm.noexec =3D=3D 1 or 2, applications that don't set
> MFD_NOEXEC_SEAL or MFD_EXEC will get MFD_NOEXEC_SEAL memfd. And
> old-application might break, that is by-design, in such a system
> vm.noexec =3D 0 shall be used. Also no backward compatibility problem.
>=20
> I propose to include this documentation patch to assist in clarifying
> the semantics of MFD_NOEXEC_SEAL, thereby preventing any potential
> future confusion.
>=20
> This patch supersede previous patch which is trying different
> direction [3], and please remove [2] from mm-unstable branch when
> applying this patch.
>=20
> Finally, I would like to express my gratitude to David Rheinsberg and
> Barnab=C3=A1s P=C5=91cze for initiating the discussion on the topic of se=
alability.
>=20
> [1]
> https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/
>=20
> [2]
> https://lore.kernel.org/lkml/20240513191544.94754-1-pobrn@protonmail.com/
>=20
> [3]
> https://lore.kernel.org/lkml/20240524033933.135049-1-jeffxu@google.com/
>=20
> Jeff Xu (1):
>   mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
>=20
>  Documentation/userspace-api/index.rst      |  1 +
>  Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
>=20
> --
> 2.45.2.505.gda0bf45e8d-goog
>=20
> 


Return-Path: <linux-kselftest+bounces-33343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9DABC7AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 21:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450D117A070
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7621EB193;
	Mon, 19 May 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="K8yro62C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3379FE;
	Mon, 19 May 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682445; cv=pass; b=eRuznQgFyIpi/wM4x0DOpbnzXLg7p+Pzr8qfgFaOz6q+9l1+9zWeg84a+ZnmjacFaRwBtO9zqNfX/E8zL7ozDjpB/eVvxZ7b6QKux9+X1EAU03G91+V5pr1XqQCULJu4lHncPefKstu9S7BAOvKWX0VymgzyaFjuMAkGChSLYtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682445; c=relaxed/simple;
	bh=BYmZcfyoELBlrBp1HZQreD1Bcc/kEOsTn3LEkRmiQh0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pUbI7ga54cd88qBgXAIC4AUeeEr+RSnW84zXN+e90n7hvRRBcLp4XjCigp+yZO4OOPwRm5oVGpnpBxYnesd51W97tmtf65LfPFxFyUzeX2Wpz3MtXUoSJva8U00u0a2XRFPf/hcQUfq1Wa0FKH7j6k8h0YUDw38Q2yaKb5oH1Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=K8yro62C; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747682429; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cKfGCiwOqmOz+aSRbln1/Ib+ptkj4zzNIxPxj0GKWiWPjtZdJVl6ZMl7JXBVa3o2E2Q77FnPhf9lHT1u+sT5Mivu5A+XV89h1UuGXk6UJNrLpdqBzpcWeUsEZvOI6Gu7KRd2A7s0sBmXf7lEVX1MUJuxIz3Bqi02llIJjpxWqx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747682429; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BYmZcfyoELBlrBp1HZQreD1Bcc/kEOsTn3LEkRmiQh0=; 
	b=NKbu+ngRRcdBzEFVnvFphUgRZ0xJEp08Mtm8ARFcRYZBewN5JhIwgQlPfh7DO7O5py1h5kEsUH93y4nCr5j44kNw7En4lubGj/nTHWkcFX3QGkkTXDeG+WxOGoIdK/FKpTbuXNT/2pcbITuCuoTjzll/lgfjdLT0XpvE3iyl4Fg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747682429;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BYmZcfyoELBlrBp1HZQreD1Bcc/kEOsTn3LEkRmiQh0=;
	b=K8yro62Cp+doosEQqOoZH/jfb9mMayOt3sUewTz1JsXQOi5SQVDhVyzsn7vcnboQ
	YnIaxtAXy5dEcQzJr90PHlxHavDWazHuN1fckAwWbsmXutxXudD6wTbKyzM7nhzF4eO
	EPcuwA8TbQwXKu5+EgYijJ9gfPIXBn28juDuIZqU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1747682428369324.08306608786916; Mon, 19 May 2025 12:20:28 -0700 (PDT)
Date: Mon, 19 May 2025 16:20:28 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Gustavo Padovan" <gus@collabora.com>
Cc: "Automated Testing" <automated-testing@lists.yoctoproject.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	"Linux Kselftest" <linux-kselftest@vger.kernel.org>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>,
	"Bird,  Tim" <tim.bird@sony.com>, "sashal" <sashal@kernel.org>
Message-ID: <196e9fd85b6.d44fded2341548.6761365870876559180@collabora.com>
In-Reply-To: <196ca91a75b.e0a5fd292825092.4995709177992280379@collabora.com>
References: <196ca91a75b.e0a5fd292825092.4995709177992280379@collabora.com>
Subject: Automated Testing Summit - CFP extended until May 20th
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,

We extended the CFP until tomorrow May 20, 2025, at 11:59 PM (MDT). If you =
didn't submit your session, it is the last chance now.

Best,

- Gus

--
Gustavo Padovan

Collabora Ltd.


---- On Tue, 13 May 2025 13:54:25 -0300 Gustavo Padovan <gus@collabora.com>=
 wrote ---

 > Hello,=20
 > =20
 > It is the last week to submit your proposal!=20
 > =20
 > The Automated Testing Summit (ATS) 2025 will be held as a co-located eve=
nt at the Open Source Summit North America!=20
 > =20
 > https://events.linuxfoundation.org/open-source-summit-north-america/feat=
ures/co-located-events/#automated-testing-summit-2025=20
 > =20
 > =F0=9F=93=85 Date: June 26, 2025=20
 > =F0=9F=93=8D Location: Denver, CO, USA=20
 > =20
 > Hosted by KernelCI, ATS is a technical summit focused on the challenges =
of testing and quality assurance in the Linux ecosystem =E2=80=94 especiall=
y in upstream kernel development, embedded systems, cloud environments, and=
 CI integration.=20
 > =20
 > This is a great opportunity to share your work on:=20
 > =20
 > * Kernel and userspace test frameworks=20
 > * Lab infrastructure and automation=20
 > * CI/CD pipelines for Linux=20
 > * Fuzzing, performance testing, and debugging tools=20
 > * Sharing and standardizing test results across systems=20
 > =20
 > Whether you=E2=80=99re working on kernel testing, running tests on hardw=
are labs, developing QA tools, or building infrastructure that scales acros=
s projects, ATS is the place to collaborate and move the ecosystem forward.=
=20
 > =20
 > Submit your talk by May 18, 2025:=20
 > =F0=9F=91=89 Call for Proposals (CFP): https://sessionize.com/atsna2025=
=20
 > =20
 > We hope to see you in Denver!=20
 > =20
 > =E2=80=94 The KernelCI Team=20
 > =20
 > --=20
 > Gustavo Padovan=20
 > =20
 > Collabora Ltd.=20
 > =20
 > =20
 >=20



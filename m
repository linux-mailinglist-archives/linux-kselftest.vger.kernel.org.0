Return-Path: <linux-kselftest+bounces-32912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB2AB5A94
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 18:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4917ABAA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1451E0E0B;
	Tue, 13 May 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="Z3r72y5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D079D0;
	Tue, 13 May 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155282; cv=pass; b=G/QvGzorp/3ajQK0qBRm+L5ulssj/ndeSdiHIvOxVMISUheM59XPLrOLJttFkRZnGkIfMSa2O0ru1NqJAp52WhOHVKVg/OPR+K1bDUMD0ImGAJg2A9564X3XkTVsbJ5Lyl1yNWi1W85yd5cQhCZWXfqOjvobYvDhgyKxjcmfF1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155282; c=relaxed/simple;
	bh=NYcR6u2+z8UCBswP/ek8Z/ej58T+DodHvB4XQXhatiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=JnpU5FpDtHYuVO0D50osmhvZapCmL0EIwSdfiZqkpTnzKlaixa4+gqW/RSVL7AWpcrC5YngkN5hEGhg+0EqIBD2jgfzQphIAvwhcT5y9UjraH0AyHmCJOk9w+qU1rTkLWcJ8Lk1/4aoCGPsXy5X7mqMFheyqOiiS0pQ8CzQji9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=Z3r72y5P; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747155268; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IpH9skOHX+g4C+LDCtnISNKnwEx0ZIvVlIdIOeVIjHgsqTDVNrUqgZrbpDmOttXpdznKN6F9q0D8/hlxnhWE8homLzP59poScaqMLAhkNdG0Y0ZVxivyUvd84OgSkdaR9IZwKRECWhR9CeN1NRVmQit0bjz2KEwB4IqWzom9IGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747155268; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NYcR6u2+z8UCBswP/ek8Z/ej58T+DodHvB4XQXhatiY=; 
	b=LNTF7tdexiULyHJfIzviYX2oA9iZ62OXqGsBRimvcPjko/fPTm9cLDyLulIpdPU0k3wEj81hihFnV+ef1LSJJ8AE3tiS2FRkZCL9BKTP7fPHbO+v8Qunx7SUjm849u337dW5C3C9VgZ9OY/TVQY3gmQdf2qVvmdKYs2pQZI09vI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747155268;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NYcR6u2+z8UCBswP/ek8Z/ej58T+DodHvB4XQXhatiY=;
	b=Z3r72y5P8x+H6X4daNQWYkv4j9E8k4xhQVBl+04jP3ObLXzAB52nAHENhNanQxe9
	MEAlfW8gileRraf1bp9lBrPwZ02vRAjsnv/cXvhTsIRaQwXAzsF6Luw1c+VfpFh9wKK
	kr9pADS84AbfoT+JPeqq1aC8ZnHIVGwdB6dIk1pk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 174715526544246.04477518378542; Tue, 13 May 2025 09:54:25 -0700 (PDT)
Date: Tue, 13 May 2025 13:54:25 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Automated Testing" <automated-testing@lists.yoctoproject.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	"Linux Kselftest" <linux-kselftest@vger.kernel.org>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Bird, Tim" <tim.bird@sony.com>, "sashal" <sashal@kernel.org>
Message-ID: <196ca91a75b.e0a5fd292825092.4995709177992280379@collabora.com>
In-Reply-To: 
Subject: Last week to submit your sessions to the Automated Testing Summit!
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

It is the last week to submit your proposal!

The Automated Testing Summit (ATS) 2025 will be held as a co-located event =
at the Open Source Summit North America!

https://events.linuxfoundation.org/open-source-summit-north-america/feature=
s/co-located-events/#automated-testing-summit-2025

=F0=9F=93=85 Date: June 26, 2025
=F0=9F=93=8D Location: Denver, CO, USA

Hosted by KernelCI, ATS is a technical summit focused on the challenges of =
testing and quality assurance in the Linux ecosystem =E2=80=94 especially i=
n upstream kernel development, embedded systems, cloud environments, and CI=
 integration.

This is a great opportunity to share your work on:

* Kernel and userspace test frameworks
* Lab infrastructure and automation
* CI/CD pipelines for Linux
* Fuzzing, performance testing, and debugging tools
* Sharing and standardizing test results across systems

Whether you=E2=80=99re working on kernel testing, running tests on hardware=
 labs, developing QA tools, or building infrastructure that scales across p=
rojects, ATS is the place to collaborate and move the ecosystem forward.

Submit your talk by May 18, 2025:
=F0=9F=91=89 Call for Proposals (CFP): https://sessionize.com/atsna2025

We hope to see you in Denver!

=E2=80=94 The KernelCI Team

--
Gustavo Padovan

Collabora Ltd.



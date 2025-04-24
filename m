Return-Path: <linux-kselftest+bounces-31605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B57EA9B9C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DD74683D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322A288C86;
	Thu, 24 Apr 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="aXvb2Bbm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568D1F542E;
	Thu, 24 Apr 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529426; cv=pass; b=LdSIvIebXEbMfkhoSCr3OUDI0TBO9sP9y5cwXPlWBVEMwkLPefovMWUCgu4UQNOkRyB4btJqJwLJ/N1XPpKsSByd+VkR1HFuSJHfr/t8DcljJP4dzbiHxsGWsSAZYRPoykAjOdfDHHKU5ThNwd+UC0oJUq+1u6rWbpk4MXQXo5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529426; c=relaxed/simple;
	bh=QLS82cc4eudeicw4nFreDbXkdPM/2XXY6liLfSrYz+4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=knURu+Scdd68CLrZE6s6CmrFVuJwYF81IiKB3jHO7CC4JVKPZEXdfpGFMzp4QvGQqDIiJq17iiUHhcdYyxTzRs/6UM4/fhqHQaN4uexnYQBbNsgnSB7ZBWdNPADrZ4whrMOBn35Yujfb/43FaOIpBYOA+3K7WvKbxSb3Mr1rhaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=aXvb2Bbm; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745529416; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TKCtdiCoomeeikgCgWSqh78WJ6xYwc0HvD0o02HVKKc2v7lTLuGLSywWDqWXWA8/g/JraHa9Aco3ZWnBg7RE/+HIoseRXQrRUfrG+mYXz5fP6VJmLPawRhFUuYWtarA598jhsEgGQxJ1zyv2FJvE7qoXAx2feYS6uiJi2j/1kKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745529416; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QLS82cc4eudeicw4nFreDbXkdPM/2XXY6liLfSrYz+4=; 
	b=L7IsbOoVGJxS6s4QApHGNDg3AIi6Eawx9vAoW26OPFjBB43yb6dve1ujM75tKOJIw/qPCEI/9E0mgSeN+NqnDK3i7GyM5HHjK0AX/sQkxNe9OTjkykAfnos3+Op9m7sCKk2g8LGZ/vLuiE7qBA4krXYpDOVN77QCnwleCeo/amw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745529416;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QLS82cc4eudeicw4nFreDbXkdPM/2XXY6liLfSrYz+4=;
	b=aXvb2BbmievZpn4iB4CT/6zjF8IUU15UIRWgiMYpJqPPc4IOdGVf1tkRZP/skUif
	SA0CmzQp4Ld/TCeYp1Lcniw4h30X4LBLMUemgC1V2/+BfIkhU3CTnpRpClky6wPqi0d
	CIRVG50lsYKCBRVr4+RwzgxpPakX/bLo/Vx5FUmQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1745529414853154.71608947901427; Thu, 24 Apr 2025 14:16:54 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:16:54 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	"Linux Kselftest" <linux-kselftest@vger.kernel.org>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Bird, Tim" <tim.bird@sony.com>, "sashal" <sashal@kernel.org>
Message-ID: <19669a924a7.c72045892114983.8731130954795337632@collabora.com>
In-Reply-To: 
Subject: Call for Participation: Automated Testing Summit 2025 @ OSS NA
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

The Automated Testing Summit (ATS) 2025 will be held as a co-located event =
at the Open Source Summit North America, and we=E2=80=99re now accepting ta=
lk proposals!

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





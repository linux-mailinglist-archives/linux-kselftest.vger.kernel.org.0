Return-Path: <linux-kselftest+bounces-37991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43291B12088
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8A71C8907D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAA2EE61E;
	Fri, 25 Jul 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEeIP7Dt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BE2ED85A;
	Fri, 25 Jul 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455624; cv=none; b=al0hml4vL8Lg+pPA3aLffO7FolstzaSBlJ2pwqQCXCMFlDs4XguxKB6u0d1Aldf0UA5C4LHu2UMmpr1239uj24m2JQIEwUXd85AJoIG+b2LsWWgzZ+72meypJmPJEjn5nFKz1l9kg0ICNDAVOR9oZ2NJTmeVz/15BmXikRwZ08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455624; c=relaxed/simple;
	bh=ddruXDerdALydeB5uaYdZPQX0TkNkBLMTVvS4Le1FOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iNi1shh1j38TlgmurGvUCXD4U6vK4yMKoSKgwmddmI6jCrmSRbqzSPIjgmOum/G4YME6SSwDuz3vdmMOH0VC0XlmOJomBPQdZJlVIYrZTIEyFCat05Jm9m81GhOfteBrmdCXYDpnI1nQlGx71+3r2gyjpha/zA2Ae1L6hkPWgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEeIP7Dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF675C4CEEB;
	Fri, 25 Jul 2025 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753455624;
	bh=ddruXDerdALydeB5uaYdZPQX0TkNkBLMTVvS4Le1FOk=;
	h=Date:From:To:Cc:Subject:From;
	b=WEeIP7DtSKVaOuVOdmP1lhXEXKiIoDt7W5DivcrwWB/6Z4Tm8nti1hoQAb/cfRRgE
	 dBTTLnCk0yinnBIesNCZ1a8x22tJiK48EHFtu+GXy8FKQ8zZNRLadtrmyofGtYKnfj
	 jK713gYYUM+obHDAk5dvcwxbsjJui+WrdgtXfDB3kAT0Ief9a7ObWi135qAKPwo2V6
	 14EkIVjBoNhd2C+UenepEzdbCOU5bpOd6vnBIXguWurZ4RznchVJGPbrmjBexSy+HF
	 +LJsuTXER+UK54qs0qBwO1BjfAK0t+sEYYbpPtrMrMLiNW7n7t45RxilaXCZMaiv6L
	 979cOr3JiTecg==
Date: Fri, 25 Jul 2025 08:00:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>
Subject: Crediting test authors
Message-ID: <20250725080023.6425488c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Does anyone have ideas about crediting test authors or tests for bugs
discovered?  We increasingly see situations where someone adds a test
then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.

Using reported-by doesn't feel right. But credit should go to the
person who wrote the test. Is anyone else having this dilemma?


Return-Path: <linux-kselftest+bounces-8619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2848ACE5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1A4B216DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A014F9D3;
	Mon, 22 Apr 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VmQC1AnE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38633399F
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792949; cv=none; b=bZ2QUvdpYXjP1KYliYwOPd1XQCMZA7MQXC9EFd7UL9NWwiTb7Z7wb7qWkoaGP8mVlArLev40cu3l6DCm5lHgfyHEMvtXpqFyOEvk39s1qwgyL4Qnevok7WPwttPBQsDB9V1pJMf/DwgpFwdfu11Iaxe0ApXhxGHf7U3hSjSj8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792949; c=relaxed/simple;
	bh=8ei9GbJZW97AshSmMUhY3QUz1TIss6EgYgqIK+FZiT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6dZ/crKcG84kWmSbh3Fx5oMHtFBjUYzUHLglK/t4nZxPxbntFMlcACT6f+d5UXUdwfEqCWJj7ALHZmaQptsbe+seFTBGFJHmhVN5Ta1s1yXH6LxnC6TDDwO872Js5ZLJgbSOTAEXVgyK+Qfsoy8uTl/+T/9mu/KDW6krl2iPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VmQC1AnE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713792945;
	bh=8ei9GbJZW97AshSmMUhY3QUz1TIss6EgYgqIK+FZiT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VmQC1AnEp5KshUWP5OrTUahsLDLn7rRptYebO2HDfidykAJXNQMqwvnTsA0dTHJHQ
	 Btwys8Y5eOQVoJj023GQ7E1j2YGsL0LoovuKQzMYOHnMyB3SZUfHZ+toYKYVUYOZ6J
	 AYh9I6qaifGsAQYm6ZUJnzaafutw5m3pChbDYqA+lJLgz9nNbjmHiTQOCXNSfvvkmo
	 9PGIlwZKNTiiz/1E7L0ywoc2IpCAHBD9eJZuTtOd++uxd51W0Kl13WMd3wLtrZzUvt
	 NgjVhdtWLcqpQCd0KIx6pCkidOb1VmF+FeAOizVMHFrJw0X6F/Dxe63SDK2Bqs0Ouq
	 rE1VNZJSWDFFw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNR8d1MWnz4wc1;
	Mon, 22 Apr 2024 23:35:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, spoorthy@linux.ibm.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Install tests in sub-directories
In-Reply-To: <20240422132746.1790844-1-mpe@ellerman.id.au>
References: <20240422132746.1790844-1-mpe@ellerman.id.au>
Date: Mon, 22 Apr 2024 23:35:44 +1000
Message-ID: <87h6ftjz9r.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:
> The sources for the powerpc selftests are arranged into sub-directories.
> However when the tests are built and installed, the sub-directories are
> squashed, losing the structure.

This is missing a preparatory patch, new version coming.

cheers


Return-Path: <linux-kselftest+bounces-8160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7488A6E3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09352280FF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2E12FF65;
	Tue, 16 Apr 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No9PgoR/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945E12C522;
	Tue, 16 Apr 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277691; cv=none; b=XYpy540vtp0dNeVLnJS5pqX35i6ZNZ3d2KlGh1RICqWbOTbfa5x/m7hIrK4M+AgQvMNcTh/chCg4BQd6Yf7lnu36WGzhSOZS9C9AQ9ZNYmfOVnTVudFohqRSD+/fdQeYV3xzEfLmRta4ancQPiOsJ2jM6J61d5Gll9U6iI8vUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277691; c=relaxed/simple;
	bh=/CMP70YEKE5aZJD43DMwgQoee9fnrUCCIlSosfdVRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGy6RnB0ivQK6eBzQbhbuVmYQq7QJ9nayxNh93kLYdNFnYV0MPTPHidRFwKS++A39xD49fobXoLF8g1K8O/UiBmPeI1uIEheP//EO5W66qw8Pz1hVqlzOnvAwpucg08C4uVQBGsxRfcWjpOUTi6f1rzFtB9t6tHQlUHhb44OUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No9PgoR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC47C113CE;
	Tue, 16 Apr 2024 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277691;
	bh=/CMP70YEKE5aZJD43DMwgQoee9fnrUCCIlSosfdVRRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=No9PgoR/Xm/Rigmzr0Fh3v/MNih1kYHRWSETuOhJGSi5tZC5YL5ZGJujz2nR0jLV4
	 +g7O9KRpvEgbwGaUhfZBY7hNSpjYEkDVnqWBpiMStL7EiUtqd1C4jjvXy0jKKVTLWJ
	 VStbWu8gpFvoonRzeHz08QmTQNP+DgerKR/8lbMxHu7Z5hv6L2UB1WI3J5kxok8k5X
	 Bz6hd1r8aZ/cR91Tu3LJeFdSUvxsFzCzwHKlXxTWXOMy4dmFyhj84GDCPSHq4+jG+6
	 s0LrBDXUIrXa/J7ATMVce+PW71+QJC50tjClwfMHsWtdyvkspbA8P5GX7RsmBnfI4Q
	 la5OkPrvly5Yw==
Date: Tue, 16 Apr 2024 07:28:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for
 TCP-AO selftests
Message-ID: <20240416072809.3ae7c3d3@kernel.org>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 02:42:51 +0100 Dmitry Safonov via B4 Relay wrote:
> Started as addressing the flakiness issues in rst_ipv*, that affect
> netdev dashboard.

Thank you! :)


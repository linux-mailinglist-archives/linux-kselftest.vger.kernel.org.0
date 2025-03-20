Return-Path: <linux-kselftest+bounces-29496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D5A6A563
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35986883984
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B88221DA3;
	Thu, 20 Mar 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akfX5ESM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219C21CA18;
	Thu, 20 Mar 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471301; cv=none; b=TZGEVURGAR/0An61p4/onaHFpYI6Nmm+O6VlKoWLVQNLdonCr7cq0DvxJnx6QYA60mSC+fkYX6rhEWjVccX6RDsfbTeX3T4sZdHwAR4pFNUWVYsMI9gNtes/gRvVjmE1PuJM6cgF5YUnyOF4nKqWAkVWLDOc0rI4wq0AezaCsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471301; c=relaxed/simple;
	bh=O2IVu4cigNBXmNScx/2VgPrtBNIInkvXokX6LChC9T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+j80NLiZerjNzSKJ9JEpXAq1fytyRR3HgwkGZHyn5C5VW2C229troqbWQzeLEWn5O9l9hnbpzrUQ11VzvDqngFF1A98s9hpZvAbe1LD0v/ZE9GUT27FLOoP1NsIS2SI3LX3FDo66zAASjX2H0AVVrmBUr7OBLwBSmDh2e6/sSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akfX5ESM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F616C4CEDD;
	Thu, 20 Mar 2025 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471301;
	bh=O2IVu4cigNBXmNScx/2VgPrtBNIInkvXokX6LChC9T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akfX5ESMEm7NY49Dn9/Qc4Cplx+GlxkiO4/qYIYCVIhYnsu7R6qaijdYlcopKAB71
	 ScSqiWCr7PjaQCcSggiA/Acv3GzYoYvyM/YNI04t6AFBdk4kY0a5ia6XCWnr8EpdX9
	 KHu23Oc8/As+iQZvmyVBp7mjr1jHieKLjE2ZrY/Q8DAXZjWQhQx9O+Cng/1eKq/TKj
	 E+VIE4819LRE5OUK3RD9W8aN/Y7/e9XPcNnnxdiuka/PZA/DB0o8pKq9E5YoK9SrPt
	 GVdg3VTxP14cXokdMXc4R9+LdvX5nHO4ZGTx9vRvzUTh//VTrPnBb1rpmowvxcGIBk
	 H4mBsicg9YkGA==
Date: Thu, 20 Mar 2025 11:48:17 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v1 2/2] selftest: net: update proc_net_pktgen
 (add more imix_weights test cases)
Message-ID: <20250320114817.GM280585@kernel.org>
References: <20250317090401.1240704-1-ps.report@gmx.net>
 <20250317090401.1240704-2-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317090401.1240704-2-ps.report@gmx.net>

On Mon, Mar 17, 2025 at 10:04:01AM +0100, Peter Seiderer wrote:
> Add more imix_weights test cases (for incomplete input).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>



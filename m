Return-Path: <linux-kselftest+bounces-30743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD0A88B05
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D2E1899AF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1928B50A;
	Mon, 14 Apr 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSjZVNzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940428B518
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655318; cv=none; b=ptdapZ7rFMuP9WgEgBRxAPIRKYl4M04A4+yfYP0Vom8kIn5v0OKPAaY6IDaTSVq3zQrIe6kVYOoOpaf+UnbQQNNHM4r3YobGYVsENQ6fsWG2NKA6wLMseRNxTswKhQuLQQhJuJRVp7KGEep9gUcttMIq2i46spxC67pOkL+X7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655318; c=relaxed/simple;
	bh=8P8YmJ7Tn5GGCxfDr6c5P89x/QkiNHi9LhfKdaKuiAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSnJ/uE6ube/lu4emRb8U8xIaAKGwmhjuuQf8cA8UoqIhQnhaQjrI0eZTx+Ph58drLTWPIqdem89jcvN9MZW6s2xbefcMihFZHLxaByrTeVKWGzoHZoFPJJEgk6ksNLdg5zbV5PILhDxpOE/CPm89hLLXdUPM4wz0Jxy8kEj+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSjZVNzn; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 11:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744655312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79LobGIFN/g0FwF2NikibVInqu9FRxv0v1rsKL+0J5s=;
	b=dSjZVNznhibE5ImQIIfmmYSCOEzofqKsfqXGZNrhtpM/7rWjE+O4flqhBfgr5HDSfKQHPR
	YBw5wp5OGPuj3czpGhC3nHMcfr4enPcFZPyfeO6MgofxP3O9atH+Z2DrN4HJ9OLmMz7yXe
	bBaA08prdifZ5EgLcXYZKc1nO9Qvlt0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Binderman <dcb314@hotmail.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re:
 linux-6.15-rc2/tools/testing/selftests/kvm/lib/arm64/processor.c:107:
 Possible int/long mixup ?
Message-ID: <Z_1TxzniVGAS6gcp@linux.dev>
References: <AS8PR02MB10217FE659681FD584050156F9CB32@AS8PR02MB10217.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB10217FE659681FD584050156F9CB32@AS8PR02MB10217.eurprd02.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 14, 2025 at 06:02:45PM +0000, David Binderman wrote:
> Hello there,
> 
> Static analyser cppcheck says:
> 
> linux-6.15-rc2/tools/testing/selftests/kvm/lib/arm64/processor.c:107:2: style: int result is returned as long value. If the return value is long to avoid loss of information, then you have loss of information. [truncLongCastReturn]
> 
> Source code is
> 
>    return 1 << (vm->va_bits - shift);
> 
> Maybe better code:
> 
>    return 1UL << (vm->va_bits - shift);
> 

This expression is at most 8192 so there's no risk of truncation,
although the return type could potentially be improved.

Thanks,
Oliver


Return-Path: <linux-kselftest+bounces-33388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCCFABD3F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB361B637C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F582268C7C;
	Tue, 20 May 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hPn7UrfE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CB25DAF4;
	Tue, 20 May 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734867; cv=none; b=VodGKf7TXRobio1P22hJ8ieZj/uhZpL90cjDrf6tqnDbw0rrUBwLnOHysl2DC84T59SWwi4Phv06ExwcA5Bjyy6p+CjNElGxPt2Tjry/NvqsXzXo8ZXIqcFwlMomVNY3pjvwGSAa7DUWiuLeJYJmC/mxOqzJELmkEEc5UMNUMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734867; c=relaxed/simple;
	bh=RtN0tBeANzHuFkoDf8IorIxYwFCPhY6UABemsNJ/eGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z56iVx/nW3CLzJlS8Z9+8eoaiBn8jzd278Jc10s4Z5S/YC0GDmUVN9pJxyYMVswcjgwkYIGFQ+hoj2ElNzvjvdxi8iTS4rO+kQOPh7TrQvdjybmOrZS+npW4f32rijUXPFC5q93yq9gAe+GGIZ6OGF1vx8/hGYH5Bd5axJVzyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hPn7UrfE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747734856;
	bh=RtN0tBeANzHuFkoDf8IorIxYwFCPhY6UABemsNJ/eGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPn7UrfE2BJ/REABHn5Nu/z0VaM7JIMXqH9+Z7zuxXFnz9Y3H2J1U/CeF47Pe5vEn
	 1uAWO2+piwl2iFA0lS9R3jO9MC8oFv3qRYAV9t7XpYhcIOUGf8cyN1tOZHKmGEDB2+
	 5pxOUwUZOL8mOg2zRjC2mlPlFnHoncVCGNBsAnUk=
Date: Tue, 20 May 2025 11:54:15 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Rae Moar <rmoar@google.com>, skhan@linuxfoundation.org
Cc: davidgow@google.com, brendan.higgins@linux.dev, dlatypov@google.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: add test counts to JSON output
Message-ID: <dbab6e52-de79-458a-88f8-c771dec4a2ae@t-8ch.de>
References: <20250516201615.1237037-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516201615.1237037-1-rmoar@google.com>

On 2025-05-16 20:16:15+0000, Rae Moar wrote:
<snip>

>  	test_group = {
>  		"name": test.name,
>  		"sub_groups": sub_groups,
>  		"test_cases": test_cases,
> +		"misc": counts_json

Should have a trailing comma for future extensibility.
In case history is rewritten anyways, this could be fixed up.

>  	}
>  	test_group.update(common_fields)
>  	return test_group
> 
> base-commit: c2493384e8110d5a4792fff4b9d46e47b78ea10a
> -- 
> 2.49.0.1101.gccaa498523-goog
> 


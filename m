Return-Path: <linux-kselftest+bounces-22517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD39D8F38
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 00:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0668F2846EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA5195985;
	Mon, 25 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg6Ut+1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7681E480;
	Mon, 25 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578020; cv=none; b=bgQFPn1eH1/EqI5VGN3u6qwQn97OF2UQWvE/ANpoV6s1azR+NiCh6bCOSiXUzZWI62224GnYhaFWC0b+zdtKD33HsgAB3NiN7B90GuPEDKmKSz5PPlDwp4B86+y8S49XCPdA2Q4zij8FwVDFavJsyBfZ4aGfH59JqaXdkdznjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578020; c=relaxed/simple;
	bh=/DWbhcJbPqsr/l9Ba79rt42q5uBE42dNGMfmTYIGm4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imJfl/5CJbjEefazWTwFioNasGBn3/bdsTTkzhToH9zEN3pazFQEQ+c+SMrEj+wkAjyaEQvCdpfsWVhlhp/CcW49xGBvzNatDAYnK3NgE6TUvbxxG+l1IaxcJOPYbxO/q3Adt/M2+EQ1BJEO0Cf3ozsA5DrfW+ruX5UUXnOcpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg6Ut+1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3878BC4CECE;
	Mon, 25 Nov 2024 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732578020;
	bh=/DWbhcJbPqsr/l9Ba79rt42q5uBE42dNGMfmTYIGm4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qg6Ut+1u3KYMvo+RhvvkBBBbghU4yfi5BHM+/qkLSI4aGzkj2zAPteKMCi68Fg44k
	 tWjUqkNCvuQ1hEk3DZGnbSMA0g4O83HhA/5M4eBRLJXZdc/QLpWEHX+iHYtRm7fm1W
	 0j8CeHTW92O46DgJ6+GCfvChcVHvanmEyjtAzGOI54yvyJ/yd8DplyEhZnqzOvazPQ
	 Gc2soh3AASNY6el/PyPRJrLT8QP+Ae/YAicw98RzktQiigrZoRCGLm+i3Ux5zNGury
	 zv5iTQV0mai+IcQeYPBl0ZMig9fhUlJR6TzTWSgEb06WhUkWQTqjsofSwYrDB3GdvR
	 2CE3PtX4QcdFQ==
Date: Mon, 25 Nov 2024 15:40:17 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net,
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
	akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
	pbrobinson@gmail.com, zbyszek@in.waw.pl, mjg59@srcf.ucam.org,
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
	jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
	petr.vorel@gmail.com, mzerqung@0pointer.de, kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 02/15] module: Introduce ksys_finit_module()
Message-ID: <Z0UK4Zm85GzeLt20@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
 <20241119121402.GA28228@lst.de>
 <ZzzwxdHbG9HynADT@bombadil.infradead.org>
 <70952351d25817211509bf1cf43d3e665aef1481.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70952351d25817211509bf1cf43d3e665aef1481.camel@huaweicloud.com>

On Wed, Nov 20, 2024 at 10:16:23AM +0100, Roberto Sassu wrote:
> Again, maybe I misunderstood, but I'm not introducing any functional
> change to the current behavior, the kernel side also provides a file
> descriptor and module arguments as user space would do (e.g. by
> executing insmod).

The commit log does an extremely poor job to make this clear, all you
are doing here is adding a helper. The commit log should be super clear
on that and it is not.

  Luis


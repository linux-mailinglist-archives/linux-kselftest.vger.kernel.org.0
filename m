Return-Path: <linux-kselftest+bounces-38099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08BB17348
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497C116D66E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4602188734;
	Thu, 31 Jul 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gustavo.padovan@collabora.com header.b="POiETy5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB284D13;
	Thu, 31 Jul 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972259; cv=pass; b=fISszrqdv5ZKb4r6laKdiqjUo7vlIAsJTDI6RgbkxigPUZ5rhZHikxFpM5ClaJbQT8bk29H2IZ9SjboROPCx+4fVmZfRSWL2GiqfSHxXkETORpIVtU/eMLULy+NGYutEYjvUmvkA6QAqDJUsP5N8du7Fk1AJwUnuYyVh1u7LxH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972259; c=relaxed/simple;
	bh=Zr3hVL7N0aADXqk+uqAeO6NgXlGFKxOaU+aHUiGpRbw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DzG7b/suET6Gbsus9dN09fdBV9vJcA03qgHxhfSfEwRQv/5bPeIBPHqmSE8Fpq+ISy9lvCeVo2GKSybvAOg9/Nwvs64PH0PgdtOgabo92pzgpNISiW+Tr2Ba1N3t+99UBjYyyPlhNkwIojiVhalht4FRuS2/sMKZli8/4jJySBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gustavo.padovan@collabora.com header.b=POiETy5z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753972246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WRBRS4nVPFimMKU8qeqE5cORoe9+XPAWI7FQA5RZGN9Vc3IGIHmx6UowFqFUMoya2dGOfxUobAb2SCxVGOuudatur2NT85DrEhbq5o3XHa25/asc0uG+yFBG9oOF2N6V8lZFcvJs/dknoyq8rbXEX1YONg9RBzTf6Rfgh3VhDDI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753972246; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yY2cpF6BjorCH3612wdlhId4jFFHB7ft6u9efzIyu8Q=; 
	b=TkeNwqfqRZqzdbvV4LCw7bYccvEYlaC+YOD+hJB7f/Ekxbww1u+FTkkwqBBJq67Vb9MtD7siGhJrunX/cdCy8k6JE8z+VgFZzTwT/m9uZWp/WinFrQR8uEyucM+YUnKP1CqrTG7BKYR7Rkr9JvyyHeym+2JdvxqQWgnxkMTXekI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gustavo.padovan@collabora.com;
	dmarc=pass header.from=<gustavo.padovan@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753972246;
	s=zohomail; d=collabora.com; i=gustavo.padovan@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yY2cpF6BjorCH3612wdlhId4jFFHB7ft6u9efzIyu8Q=;
	b=POiETy5zpsCiy/PKRkZ+QCJlYKj0DrUeNWx1NP5qylIfy+vfxKiOeiVJb7yAA55U
	GjjlAn1OFoL1qvXnTeEDX0GI8vSSMhlBVzzKYZyJV2qLdQUzyzb/QDRCQTbASbIfVMr
	5OSNUsWAM8DydLlkL7kbsl5fn7hmHKZBMywe9f7w=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1753972244087956.5570993398783; Thu, 31 Jul 2025 07:30:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:30:44 -0300
From: Gustavo Padovan <gustavo.padovan@collabora.com>
To: "Mark Brown" <broonie@kernel.org>
Cc: "dan.j.williams" <dan.j.williams@intel.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"workflows" <workflows@vger.kernel.org>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Donald Zickus" <dzickus@redhat.com>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>
Message-ID: <19860e47e60.2269bf19518594.1062927936810569203@collabora.com>
In-Reply-To: <aIVMPbZcmAvG9z2o@finisterre.sirena.org.uk>
References: <20250725080023.6425488c@kernel.org>
 <6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
 <20250725102019.7add0be0@kernel.org>
 <6883ced97d944_134cc7100fa@dwillia2-xfh.jf.intel.com.notmuch> <aIVMPbZcmAvG9z2o@finisterre.sirena.org.uk>
Subject: Re: Crediting test authors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,


---- On Sat, 26 Jul 2025 18:44:29 -0300 Mark Brown <broonie@kernel.org> wrote ---

 > On Fri, Jul 25, 2025 at 11:37:13AM -0700, dan.j.williams@intel.com wrote: 
 > > Jakub Kicinski wrote: 
 >  
 > > > So a tag would be ideal. But it's a hard nut to crack. Best I can come 
 > > > up with would be: 
 >  
 > > > Reproducer: test.case.path # 001122aabb (optimal) commit of the test case 
 >  
 > > That's true, more than a few times I have had distro folks reach out to 
 > > ask "how do I verify this backport" and end up manually pointing to the 
 > > new unit test that backstops a fix. 
 >  
 > > Although, from that tag I would not know where to get the commit. Maybe: 
 > > 
 > > Test: <git url> 
 > > 
 > > ...as a new Link: type? 
 >  
 > It seems like there's some overlap here with the work that people have 
 > been intermittently trying to do on test cataloging, eg: 
 >  
 >  https://lore.kernel.org/workflows/CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com/ 
 >  
 > That's been approached more from the "what tests should I run?" end of 
 > things since it's been driven by people interested in testing and CI, 
 > but it feels like there's a lot of overlap with the describing the 
 > suites part of things.  It'd be a lot easier to write and read tags like 
 > the above if we could define some more compact names than git URLs for 
 > suites/tests. 


I see the overlap too.  The catalog discussion envisions a mapping of which tests
should be executed for this folder/file or function. This approach is being used,
for example, in the Mesa project for its CI testing. When a new PR comes in,
the system will trigger tests based on the files being modified.

Our discussions on the catalog side are quite basic right now and happening
through the .kernelci.yml file[1]. I believe there is a possible future, built
in a step by step manner, to indentify for given patchset:
 * configs to test
 * arch/hw to run tests on
 * tests must be executed
 * expectation of pass/fail for each test

KernelCI wants to work with maintainers to figure out how to make progress
on that.

[1]  https://www.youtube.com/watch?v=-LtK1fScFww


Best,

- Gus






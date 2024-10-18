Return-Path: <linux-kselftest+bounces-20139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E59A410D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01D1B2269C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB31D969C;
	Fri, 18 Oct 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gustavo.padovan@collabora.com header.b="SdVbTYML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246E13C8E2;
	Fri, 18 Oct 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261415; cv=pass; b=ZfkBl+/p7LHKLImpV+bAGVnO6ZkyBOHc0XruddjKKcbQZkgEz8eeW2q/k3jiUfFyVDnAiOe8F5nSlM6F4qWMlCIfoSKGc0LFXLrEnvcJGgN8CjCfFEji5BQrCpH4ZfMpk6mKxk7D2oGqC4Rs2vpD+jir8tgqqIx/mtEBtNT/nmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261415; c=relaxed/simple;
	bh=fwm6F1waUYlZmpjON4M0/tCzSIvM2BeoAkSP9zIsXrk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E/9nc5nKQMULRMZzZRO+pKhnBb6mX9hNkTEGwkjadvRvSTPTMjCnt5yLPPfp81uEk982MI8RgYFZ/Zp3HQfbFJMigMq8Tx5RD3+LQcoLpjyQeLbero6JPwdenB9ngoxNDepy1vgCUetxQaSds36fRW+OhfV8pViq/Py3hqLivIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gustavo.padovan@collabora.com header.b=SdVbTYML; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729261402; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KIAyqUQN30RwIjlwXi20mKsI54vVnEuAng+Y8CaGIai+bz4Nr/F01424pAMQx3oBw8KFPw27W9c4UoqXL3YoD7qxxJCOzSn+4BU1UTUNrhOonqmBc/kXmr8aKRsnwYtD7hCspnmqZwTjVWobawDZIDQ8cKyfGCGxMvGBPyfbiys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729261402; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QIAhrezxUtXF4gEkgEiGP9TNMCNjCrJRts1YkaKxqFI=; 
	b=WGJ1SKvsO+nCHjc1P1osPTV1J5b9BWqdj9aEX7dw2bxj+bQ1IzCxugEoDGlRT3YBm87qR+g3BNEEuEfVBOrT7JpJcKKuQ/S1FiWq2c1FXp/CjbpHQ2B6mRizLwVY1HEio56jpIU6nRLo/ve7PywZj0dkwAbHYJ2KZWaF+aSBg4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gustavo.padovan@collabora.com;
	dmarc=pass header.from=<gustavo.padovan@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729261402;
	s=zohomail; d=collabora.com; i=gustavo.padovan@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QIAhrezxUtXF4gEkgEiGP9TNMCNjCrJRts1YkaKxqFI=;
	b=SdVbTYMLJyJzgRy0P4SqEXPiv9stROswwkByYJp7uSSheCpliLqk/wfyAZoHqu1B
	WA27D2/AC4xpbTw8InZ7fHG5WYg/zJvm6nkSG0FRhf3Bh+k2+3O3SWKtagr0gB8PFLf
	DcpoZMIOH8OhRz50Awbd+26fJY9UJ2rymdSMRcTo=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1729261399679794.5165976461445; Fri, 18 Oct 2024 07:23:19 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:23:19 -0300
From: Gustavo Padovan <gustavo.padovan@collabora.com>
To: "David Gow" <davidgow@google.com>
Cc: "Donald Zickus" <dzickus@redhat.com>,
	"workflows" <workflows@vger.kernel.org>,
	"automated-testing" <automated-testing@lists.yoctoproject.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"kernelci" <kernelci@lists.linux.dev>,
	"Nikolai Kondrashov" <nkondras@redhat.com>,
	"kernelci-members" <kernelci-members@groups.io>,
	"laura.nao" <laura.nao@collabora.com>
Message-ID: <192a002ee68.e1e6c6282027214.1199547115557464780@collabora.com>
In-Reply-To: <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com> <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
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


---- On Fri, 18 Oct 2024 04:21:58 -0300 David Gow  wrote ---

 > Hi Don, 
 >  
 > Thanks for putting this together: the discussion at Plumbers was very useful. 
 >  
 > On Tue, 15 Oct 2024 at 04:33, Donald Zickus dzickus@redhat.com> wrote: 
 > > 
 > > Hi, 
 > > 
 > > At Linux Plumbers, a few dozen of us gathered together to discuss how 
 > > to expose what tests subsystem maintainers would like to run for every 
 > > patch submitted or when CI runs tests.  We agreed on a mock up of a 
 > > yaml template to start gathering info.  The yaml file could be 
 > > temporarily stored on kernelci.org until a more permanent home could 
 > > be found.  Attached is a template to start the conversation. 
 > > 
 >  
 > I think that there are two (maybe three) separate problems here: 
 > 1. What tests do we want to run (for a given patch/subsystem/environment/etc)? 
 > 2. How do we describe those tests in such a way that running them can 
 > be automated? 
 > 3. (Exactly what constitutes a 'test'? A single 'test', a whole suite 
 > of tests, a test framework/tool? What about the environment: is, e.g., 
 > KUnit on UML different from KUnit on qemu-x86_64 different from KUnit 
 > on qemu-arm64?) 
 >  
 > My gut feeling here is that (1) is technically quite easy: worst-case 
 > we just make every MAINTAINERS entry link to a document describing 
 > what tests should be run. Actually getting people to write these 
 > documents and then run the tests, though, is very difficult. 
 >  
 > (2) is the area where I think this will be most useful. We have some 
 > arbitrary (probably .yaml) file which describes a series of tests to 
 > run in enough detail that we can automate it. My ideal outcome here 
 > would be to have a 'kunit.yaml' file which I can pass to a tool 
 > (either locally or automatically on some CI system) which will run all 
 > of the checks I'd run on an incoming patch. This would include 
 > everything from checkpatch, to test builds, to running KUnit tests and 
 > other test scripts. Ideally, it'd even run these across a bunch of 
 > different environments (architectures, emulators, hardware, etc) to 
 > catch issues which only show up on big-endian or 32-bit machines. 
 >  
 > If this means I can publish that yaml file somewhere, and not only 
 > give contributors a way to check that those tests pass on their own 
 > machine before sending a patch out, but also have CI systems 
 > automatically run them (so the results are ready waiting before I 
 > manually review the patch), that'd be ideal. 

This though makes sense to me. It will be very interesting for CI systems to be
able to figure out which tests to run for a set of folder/file changes. 

However, I also feel that a key part of the work is actually convincing people
to write (and maintain!) these specs. Only automation through CI we may be able
to show the value of this tasks, prompting maintainers to keep their files
updated, otherwise we are going create a sea of specs that will just be outdated
pretty quickly.

In the new KernelCI maestro, we started with only a handful of tests, so we could
actually look at the results, find regressions and report them. Maybe we could
start in the same way with a few tests. Eg kselftest-dt and kselftests-acpi. It
should be relatively simple to make something that will decide on testing probe
of drivers based on which files are being changed.

There needs to be a sort of cultural shift on how we track tests first. Just documenting
our current tests may not take us far, but starting small with a comprehensive process
from test spec to CI automation to clear ways of deliverying results is the game changer.

Then there are other perspectives that crosses this. For example, many of the LTP and
kselftests will just fail, but there is no accumulated knowledge on what the result of
each test means. So understanding what is expected to pass/fail for each platform is
a sort of dependance in this extensive documentation effort we are set ourselves for.

Best,

- Gus







Return-Path: <linux-kselftest+bounces-447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C97F4937
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 15:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F481C2084C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8894E1A4;
	Wed, 22 Nov 2023 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8kCYs0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82508112
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 06:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700664306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/w99k4ebalupsRXy3umX36OydNbePrrZgl9ysNBYTzc=;
	b=Q8kCYs0OcPy1oXMB1+2EOWDpiVOiKh40M7AAb8hTWLRKGFHMy9qJUAAyf4da1E9k1aE6Mu
	eq5kiTRkKdLWEc++0NVicCGONw8A2QP5wXMoFC4Ul42vGZB+1MgwBBkyFTnTuJMZvf+Jzh
	HRF+UbY08c5V1IdsbGXhAV+9mS0Ufuc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-CKUZSvU8OfmnPwT2IPMIxQ-1; Wed, 22 Nov 2023 09:45:04 -0500
X-MC-Unique: CKUZSvU8OfmnPwT2IPMIxQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77893b0a2cdso831175785a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 06:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664304; x=1701269104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w99k4ebalupsRXy3umX36OydNbePrrZgl9ysNBYTzc=;
        b=LwrITWOViZfQqtSKomaKZ1teMvH21bZXdCLzAroVadwwTZe/de4vNYUxwyBUpy05WT
         Dw/smbZIGq1VhfS7o0gW4Hi7ecpj3qU2/wGwZ4I2yd+KnHlq1Psxxz5A2prFhJn9vgsD
         K6El2zvKd9z7P4s+pZogIHOYO4op8jrvGh1Enedf37fXwkXyFQqGIJaqCQZWkxGifmSI
         8xEXbMThRGBvsbPFKW1EnirHlA2f6ocoelFHlvKCQaDKdeWN7W6I8BvgFZdf4/GJU8Gk
         2t167Okj30ZEMjOSF1ft4AOjRPDksCX+msRRwVC1bmnNKzDQPhs09Y4oUJyCMtzheHCh
         iPYw==
X-Gm-Message-State: AOJu0YxZR2MYVB2SvB+fkRR1j10l+aFvhGVQ57ZPRpIsPbXBECOaOuux
	Vetw1O0HO40LwAmLXJnxiBO5/ORtyKh4C4vqIZ/o57jPQsAB0Ar3+81PQutSabuYSR0Y/NxWzdf
	bl7fqZh232Mntj8/57qIqGUUr7JJM
X-Received: by 2002:a05:620a:1646:b0:77a:6f81:59c1 with SMTP id c6-20020a05620a164600b0077a6f8159c1mr2374230qko.10.1700664304107;
        Wed, 22 Nov 2023 06:45:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDuHniv0gzYpUJTHcuWjypHxbcwH1q2sUJA7UQdbVeNJCWNMOviHrkiOi8wH8b1NUD9dZweQ==
X-Received: by 2002:a05:620a:1646:b0:77a:6f81:59c1 with SMTP id c6-20020a05620a164600b0077a6f8159c1mr2374204qko.10.1700664303831;
        Wed, 22 Nov 2023 06:45:03 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id pe41-20020a05620a852900b0075ca4cd03d4sm4504015qkn.64.2023.11.22.06.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:45:03 -0800 (PST)
Message-ID: <cd2d6ed9-7047-4090-ab44-16540f503087@redhat.com>
Date: Wed, 22 Nov 2023 16:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, workflows@vger.kernel.org,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
 David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev, Chandan Babu R <chandanrlinux@gmail.com>,
 Dave Chinner <david@fromorbit.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
 <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231119225437.GA292450@mit.edu>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231119225437.GA292450@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/23 00:54, Theodore Ts'o wrote:
> So as for *me*, I'm going to point people at:
> 
> https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

...

> (And note that I keep the xfstests-bld repo's on kernel.org and
> github.com both uptodate, and I prefer using the using the github.com
> URL because it's easier for the new developer to read and understand
> it.)

I already queued a switch to the kernel.org URL, which Darrick has suggested.
I'll drop it now, but you guys would have to figure it out between yourselves,
which one you want :D

Personally, I agree that the one on GitHub is more reader-friendly, FWIW.

> And similarly, just because the V: line might say, "kvm-xfstests
> smoke", someone could certainly use kdevops if they wanted to.  So
> perhaps we need to be a bit clearer about what we expect the V: line
> to mean?

I tried to handle some of that with the "subsets", so that you can run a wider
test suite and still pass the Tested-with: check. I think this has to be
balanced between allowing all the possible ways to run the tests and a
reasonable way to certify the commit was tested automatically.

E.g. name the test "xfstests", and list all the ways it can be executed, thus
communicating that it should still say "Tested-with: xfstests" regardless of
the way. And if there is a smaller required subset, name it just "xfstests
smoke" and list all the ways it can be run, including the simplest
"kvm-xfstests smoke", but accept just "Tested-with: xfstests-smoke".

I'm likely getting things wrong, but I hope you get what I'm trying to say.

> Along these lines, we should perhaps be a bit more thoughtful about
> the intended audience for Documentation/process/tests.rst.  I
> personally wouldn't try ask first-time kernel developers to look at
> the xfstests group files, because that's just way too complicated for
> them.
> 
> And I had *assumed* that Documentation/process/tests.rst was not
> primarily intended for sophistiocated file system developers who
> wouldn't be afraid to start looking at the many ways that xfstests
> could be configured.  But we should perhaps be a bit more explicit
> about who the intended audience would be for a certain set up
> Documentation files, since that will make it easier for us to come to
> consensus about how that particular piece of documentation would be
> worded.
> 
> As E.B. White (author of the book "The Elements of Style" was reputed
> to have once said, "Always write with deep sympathy for the reader".
> Which means we need to understand who the reader is, and to try to
> walk in their shoes, first.

Amen to that! Apart from the newbies and just people working on other
subsystems, we should also remember to be kinder to ourselves and keep our own
tools easier to use. So perhaps just say "newbies should be able to follow
tests.rst", and enjoy it :D

Ultimately, I think the (admittedly elusive) target should be the ability to
just plop a command line into every V: entry, running something from the tree
itself. Meanwhile, we would need the stepping stone of tests.rst, or something
like that, to walk people through whatever setup is required.

I'll see how we can accommodate the commands in the V: directly, though.

Nick



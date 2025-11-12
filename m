Return-Path: <linux-kselftest+bounces-45404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D196EC520E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41D965033B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696430B53F;
	Wed, 12 Nov 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL/xRgqY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwiNzKk/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37730DD01
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946861; cv=none; b=HliX1HJ1e/G6Qnvg3dOUkuf0NGOlGMm8xJbMNcov0lcfng+SjlRWhOb9uTE5vG+PehRYDaa827p2KKPotlgvcBDIDY7kqqjCJbkTbQU5qW2STqhuDBw29SM1D5wOboXrDCCtxDA770pNxQ9/owMorxaAl7eYt3xGGct+79d73eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946861; c=relaxed/simple;
	bh=xRBVszb46PCRdqH1h26lnmIbsU3o+gPYt33KkTm/MtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsH6Laa30FqfIGnyIERRRmwWmg+UyA3elcv+89LHxjboQLYOUjb7xRfjkaNrfWCLsdPyjxrRG4TYHmq20sLUDSmTfgQjW+MZ5iNsX2eCFOo18jlkno5obfy9HmhrqUxiyG3ORvkfrbn3Wb8ocCmXXn8wL3dORJ0lQjZr19foCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UL/xRgqY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwiNzKk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
	b=UL/xRgqYISFIpUCC23pav+X9Afc3zSklz6Ni1wzKtpHgxd0fUiBd0SiZ1XbJxkgLvQu2lQ
	m85OkaYKSPhJpjPVo26hA0mc7Aik7XMBuNDsZrMa9lnexcL5bucdw++I9zRZ+kxDbxHGNp
	Q4JIaQBEPkiIpLc/2nXKCfXnG5cjYQA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-FieJdX46OvG2zDaFyA0FXw-1; Wed, 12 Nov 2025 06:27:37 -0500
X-MC-Unique: FieJdX46OvG2zDaFyA0FXw-1
X-Mimecast-MFC-AGG-ID: FieJdX46OvG2zDaFyA0FXw_1762946857
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b245c49d0cso195936985a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946857; x=1763551657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
        b=HwiNzKk/ipkanZInrPGA4dGIyMGH9MMLsIGqg81shKdAxMIWQn28to8u0YbdwtN5Kq
         Ij1XFwQnrkcj28euGmHyUSPCZpAgxOtgTaUGotJbdzaPT+vfK5ZPC4oFO8s3exTKZcMd
         7oyBNKwj3Mq0EV00hu/1e5YQ+12gFvjApRbCMkyeXHy1pkJhluZoMqu99TGq6PDd3bCb
         QvRFSP/GJYrkM5WU2f/irGr4sBfTMzy99rGCE0YYv7dFIl4wCEdEwxfLXXpvxkzgZMiG
         Ed06dtr3YBjR2oIkPKxBJyI/9C7P3JEUiMLfAWIYqI2FnummH3En8y5TLSlgHbBbi+GN
         WxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946857; x=1763551657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
        b=ZIzmIx7JH6k5sWIwteqpjoQGMLpF7JCVPuddLOMqBpPoOzyHmTNDeh+36VrccGwD0/
         FOmeYfwKPRRe4A5tWdBuGJESrq1c7pRnnu7rxc7NSViX3yAb7L6pT0Ar92loDTXi07rD
         xWOKdT/MPLKWeZnVEgfjWmW3KqC2KO169TZvpza/ohqWHxcqvNtBPi3MiJTcZLtalUKA
         zU8a5c2z9ekd02x4XCso7IdwGtPFv11txUshZ00AES1iH7BeFUNUdaIhFy38dWSvTRso
         Z9BvhWJzyIj/spelPw71fLGL/8chlmQoNGtfY5xeYa0qvpyjMPqeBGpVxMl8AqrY7Rez
         OT/A==
X-Forwarded-Encrypted: i=1; AJvYcCUBCBBZltC2rh6mnIE2yaIKJLF33u+oGgfQ1aMylNV/ZJtbpWAiXGOWOg9MKfwCu64KCuEzQC7Kceuh5+mifM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPvzlbNc1txZ4PGhSjc+jlRvXDK9SDOTYi3aLGjtUlD0EYN/F
	6bX8AoEftFCJl7agr4aJs/7S0yg+MD4DjAocLf+0DJdOXG5X+ijLh1Ay9WSM9bfISoUVBoPSw22
	TXbABgE+i/fnZg5dzOKl7H+G3n2z2tsFOSXruSCkzsrpHLB/OHaoFn7gyEubMZqjrATuIgw==
X-Gm-Gg: ASbGnct4qNSQdpB5sfcLkAAE4uzeGrKUWLTvHbLHTT01BJ/YC19hBp2yePFvZ+GFgVu
	LipWnn+r3OD3i5dO6nvtahO57aydLq2gkf9t1Q9iJ6WNUQQaQiyR+Z7WccQ/Gh8rCtEKPesnYYq
	MtEKL9AeuIC0FPbkJkf/LxE39vZOHbDp6wB73n5cKzg61t7UcO94poUKzK6vAYhJGiY3vWkdBhG
	NF0i1NZ3p+eOGUMeGFf8PN4aRGlvwkZsX98wdzBv9KUYI5/ai10cP2x3oY74V/rVRoFL5xsEX6A
	ymGUy8oZBDWZf8WlJEuiZcWZiiPnatY+87t8G3mqBvxSRc/CkKJdYDjeURvctCFL6rPB1b57h9M
	CU1aRjVdxcI663Q1LnfVaqrsXlBIJHsosoEBfP/KhMUXnhpctg1g=
X-Received: by 2002:a05:620a:2911:b0:8a3:d644:6937 with SMTP id af79cd13be357-8b29b755312mr300897385a.6.1762946857232;
        Wed, 12 Nov 2025 03:27:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1QM6xpF4cwT0P5BoTaUqTULeYAONrpImDd2Wx6DOvB/yt3c13Mp66Q8AvPTabRL1NdGvMrw==
X-Received: by 2002:a05:620a:2911:b0:8a3:d644:6937 with SMTP id af79cd13be357-8b29b755312mr300895485a.6.1762946856845;
        Wed, 12 Nov 2025 03:27:36 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa00850sm172322185a.44.2025.11.12.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:36 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 09/12] selftests/vsock: add BUILD=0 definition
Message-ID: <ay3utqbmbi52pizmrp6zrcitxjftyghfkotjamgeicwlwv52sj@j6jfpj35rssm>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:01:00AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the definition for BUILD and initialize it to zero. This avoids
>'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
>set to 1 and is later checked for its value.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- remove fixes tag because it doesn't fix breakage of kselftest, and
>  just supports otherwise invoking with bash -u
>---
> tools/testing/selftests/vsock/vmtest.sh | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index a1c2969c44b6..e961b65b4c6e 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -548,6 +548,7 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
> while getopts :hvsq:b o
>
>-- 
>2.47.3
>



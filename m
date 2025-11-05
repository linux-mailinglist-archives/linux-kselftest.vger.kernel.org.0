Return-Path: <linux-kselftest+bounces-44838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04713C37762
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 20:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98763AED87
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605A32D431;
	Wed,  5 Nov 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOvPxOeW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158D32D0E3
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370646; cv=none; b=LZRf9PL1D7lVy4nB1yfnoWHSM7+U2UkZLSlRJrYqWL2j+0m0cvZy20UaAKyzmWOz1IL5Yc9eEY3BSBc+lG/BVenKReDyXhAwlqEx6Amr1GEEdAkJv3bd5jHlMQG7W32zxD9sm83RueNwom1HaxSMk34tc83YxYwMxlpmq9QImIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370646; c=relaxed/simple;
	bh=z2ZuAl6m8mQF8bCGTrIOO7EDrjCj2YFxDmYFrGwTZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj6HINaT3+dbS9BQWdpkLbW640Wzbzs2vbS+/tk7z4KxdOzU5mtwm5NwGHF362YLqykudyuJn2L4/oK5ZNV0GfXmpZq/+OZLNztB5s7lim5vut9XXG8pfGD4hWK5mIHniRPn88FbJ42nEFydRG9hhvvlUzhOzfsxMTcrzFKnEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOvPxOeW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-786d1658793so1462337b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370643; x=1762975443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=TOvPxOeWbNiSApawo+YHmwxouYBYo8ZqYZuOEzZ+ITc1CUWtCoRUQ/lr1DzgPoQiB7
         HxWmzzUT5AqskIjyw271EZGQLmVtgsXuWTg0I9KiP3ijIwHsEJH155nBvBla2uwVwtBi
         IDuzL2j0SQDNkDciFyUSF9kxqDKSwrBfo0+WWeMeFQsEW6cdDSdvjANMLQTdxi0xOjvh
         OP9P2RBiSf9tF7RiSP0/ddoMYB2jhxpBD+bcLvaSIKrLxlHFyqvvSfqlQOQtAuMbf67H
         GzSKHZuo1MKh/ZE0HCFFsTsnKb0t9uQsmfsuv8ABNSqMcDPoMjWopcuy1DOs6t9XbccG
         OuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370643; x=1762975443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=kSAjeqogXUr047POv/dYvEcfPqMSO/fCriM1IJLXPm5o+6Oc7kQSqcev9we++Ay5Rs
         E+Tf+hoInDFVJjO8Bm8YwEgv3kxxWbgS4aVB5YOO+HTJ+5TK+f/Vl1tcKbFddQRnKEKd
         fF/lGjBD47PeO3mgY9Vsz3UUdo7m954rMGjvukFuJneqKzWPU3XKnZko1BvY+0XS1T5D
         6mlWTb5bloUqH2b0NYPy+STJPJl/J24aFBmTk997WcFZbDzTLZkrnKYH0Wofqf6llTUG
         bEJyjguWrgn4eCEw63zixwvXZu3N5Ls3iXI4re7hGxVyl0y86Pndo3H37HfELB88Q0iH
         Ty2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsZoycebCX7kwmPd+FpvBm6PIWM+pxqiB/x3t0I6OTdXDxAc0LIYoR8Elfs5LYvAXjMK7TbPVgcFuH5Mh0nZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwz6WutFJSVmgHSi2hvpDEy4DjJi3K1RTJdvHV4B/gGFgGYrY
	2TjHOMarTfPsWQIX2EoJzCofLokp562/eWMqe22MdgMQpd0NSNm0KE6n
X-Gm-Gg: ASbGncupYbSGtCmAA9zXvLdAYDpdINxWP/3vfixHQHZy6HjbBIRmoerD+qJ7+8HViM8
	xv1EwmaYrc6NIHLSmPwc+xi1TIF6VrWOfEM+lQ4JdEkQPL++Jwlj+XY8MtyvJ50DeO2scY6KWDV
	tedfOsf983OZ/AcAgene8bIEyBl3EqkVKJPEJ79JI+M1w6IRiKv/Pns7zoiTWN76QdlnykO6ezH
	NyBtA2/gyzwiNMR+qg2dEB1lwWL5t9gho7Q0kQZbNvEDxNK+XK90LdDjOuuW2xF1b5So5Pt43fC
	/5jZp1aZyy79cSalcfNXuXBgEdtmWO3XLhoC+ZWf/8bXKtgMemETvbTHxOwWKcrr7NSzBAYcetX
	oLy/Cc6N0aaPpPMFim0V5oPh1q03/jhlmWPPRtdWw9yACTo5TTLrixF9FMamh/2a3RnZCUyE9SE
	KbTSRmlQcIPuILE82oi0ekfW4deG1pqUkGoB4o
X-Google-Smtp-Source: AGHT+IGzkMph0aR1AuSLsLz+NyiUmW9UyqgkXIKscDfhGHTikd7KQOHT6TykmLaTJLeIJUZrZX00oA==
X-Received: by 2002:a05:690c:61c5:b0:786:a774:e415 with SMTP id 00721157ae682-786a774e5d7mr54395367b3.56.1762370643208;
        Wed, 05 Nov 2025 11:24:03 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5ca403asm61413d50.8.2025.11.05.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:24:02 -0800 (PST)
Date: Wed, 5 Nov 2025 11:24:00 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <aQukUFyuN+iJ1zv9@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
 <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>

On Wed, Nov 05, 2025 at 03:48:09PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Testing with 1.37 shows all tests passing but emits the warning:
> > 
> > warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
> > 	The following versions have been tested: 1.33 1.36
> > 
> > This patch adds 1.37 to the virtme-ng versions to get rid of the above
> > warning.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I'm just worried that the list will explode. Perhaps in the future we should
> just define the minimum version that we are sure we can support and the
> maximum that we have tested.
> 
> Stefano
> 

Sounds like a good approach.

Best,
Bobby


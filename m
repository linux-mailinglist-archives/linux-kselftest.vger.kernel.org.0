Return-Path: <linux-kselftest+bounces-49354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3890D3A6FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52E3E300EDB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D55313E03;
	Mon, 19 Jan 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epBRBT7c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55987313291
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822588; cv=none; b=eAnNADGvTXohG90R+hQ0J0t9bxL5DpZHGf/vzQzDaB0QmQAbsSCDBAv5Q0jjWfFQIPzgFdh4pSyCgq7C4wmPeB2ZgWycX0gy3SiBbZvsSN2QtyWkC8d1J0zYHWnH0YJ2AZYiz/UxpDWyyCR7S1U6jUka0yz6qbBJlTyq9vUCbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822588; c=relaxed/simple;
	bh=/4Kot4dqgtCYVgtIwmsRfrcIGEeUI2K4K//pbiu03tw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH9Er3fuuXz65OlWMo35Xkseg2zSSTFXDmmW1AtnEviE2XK4rIsegSCcDnuC0b0vTc1xYMLdTzcbobe+51yTISY/hjUYAZktRj/vpfeGX/+5yoVC3BaB/uWVB3ZFTudUZ6xZZz5kcBpINhxpipdc2Dxv7tvn6+dNDhd6Zjw9KWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epBRBT7c; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-598f8136a24so4724644e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 03:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768822584; x=1769427384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFpnCWhGNwWJuXsGKzqihX1fGRnDgxZyJ8bknQ6BEd4=;
        b=epBRBT7cofdwois1COaXrgctmVZNhfCBPf/WUZly8AqL5l70uYDPWCAYI6OvBt4Be5
         ebYJmTLLec9VZKr/5q8AzEwjNHGfyQaR+Lb8Z7ReMFBwyFbhjmAo+4RdVCE39gsEJFI/
         cXjH6A8BtCyScCaAt8BFib/ZkKoS+WOeFgZNQejhfB3j6FBE+tEMjvzxt7od3H72KOGk
         mOYp4CurxMKrmYpEC1oTfjaj+IWeW9VdU/IETdnMRnqltDCkJ6SHgcwt6shpNy7b0zrE
         PLE1C0tkpeTIFOq1yUMu5/BP+nNy63OvEZD2jMHcoIZsxxSND2k9W2EjkQyy9tlda8QM
         Bq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768822584; x=1769427384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFpnCWhGNwWJuXsGKzqihX1fGRnDgxZyJ8bknQ6BEd4=;
        b=IBtls3WIjr86SG24rImruHWVdBGcFkftEfRPeF8cHI5UNN+CH9JxemfAY83S5XoF/M
         IJtY/fjFwHuMFngOzbgAkFHcsCx41f6BwITOxAzd9Y4tXjSg/HvtsP2zf3D52iwAjaGf
         Y7ip0BJVJSU52fZieVoWX/p8pu1U2oRxj3sOcKDxVXXw5R3Qop/e3KNxp+NqXmO3JHcV
         MwiXS952p3TFRuc/u0+3lzJmOTqnWuVL414RgSS5j9Z9+fxJ+ULN42Cuq6IdqbzbyIq0
         yJT76agSYdnPx7pAvNhnRztK+Evf2de4epLTpvBXWp58RdCYGFXspngC2hl8EtDXU1Zp
         RSKg==
X-Forwarded-Encrypted: i=1; AJvYcCVTLxwAbVIPLHedOL0KgAZ62Bb2K8n2bxq4U0l6RzuUvTlEaTEdkyBUAGz1+fOZAfFM04EavJtMIFC/S5pduNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxumw18T4ILUh5MC3A0uwH1hIot1FvWyyGJNMqwinoNfGqBxb7g
	CoS4IaKcxJYofbS3LIofbOPfr631LrAJjAiNKDqgUGZgFQ2uFYaB8sI7
X-Gm-Gg: AY/fxX4uLRlGeZFHPfV9P4EJjfUU3Dzwn8Hk80PLd1kJtwI3rKtvctxq69vdsZMHVjA
	iB9JmB/Y9hm5IYsrypKEXOlO18uGVyBwGofKb8XQps7WwFwgkbeNg53CULb8ZeZPDdXvYamw4rC
	LhycRSc48Ga2WtJR10Vnbuhg6nUz03ke/hs9eirf41gsC0IkDJIx9IajvCuPSfg4EO+ZLDVOPVG
	SpNtSagRzVlnwuDkJiD+Bbip4pVGA21NW6lS3cuJG/geWs+IdPyMv32mbJSVRTtFuZIixVjPn3+
	CKubAyCCoGTSTc7brakO7lfzVzAseohEvJB6kHYcCiF/zk/zAwBlgDQ45Myjk3sfGYYBoPnK32R
	LE2qMUk72v/Jf7Y++oVJ4DUhRFakgAzJq8yga9x0v2AQf4flJFRXb
X-Received: by 2002:a05:6512:3b07:b0:59b:b3e3:c7fb with SMTP id 2adb3069b0e04-59bb3e3c825mr3094854e87.9.1768822584194;
        Mon, 19 Jan 2026 03:36:24 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf397ae4sm3285108e87.59.2026.01.19.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:36:23 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 19 Jan 2026 12:36:21 +0100
To: Audra Mitchell <audra@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhocko@suse.com, surenb@google.com,
	rppt@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, david@kernel.org, urezki@gmail.com,
	raquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/test_vmalloc.c: Minor fixes to test_vmalloc.c
Message-ID: <aW4XNSD6jzHUZlWn@milan>
References: <20251201181848.1216197-1-audra@redhat.com>
 <20260118173036.fd0784f59848303024065b9b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118173036.fd0784f59848303024065b9b@linux-foundation.org>

On Sun, Jan 18, 2026 at 05:30:36PM -0800, Andrew Morton wrote:
> On Mon,  1 Dec 2025 13:18:48 -0500 Audra Mitchell <audra@redhat.com> wrote:
> 
> > If PAGE_SIZE is larger than 4k and if you have a system with a
> > large number of CPUs, this test can require a very large amount
> > of memory leading to oom-killer firing. Given the type of allocation,
> > the kernel won't have anything to kill, causing the system to
> > stall. Add a parameter to the test_vmalloc driver to represent the
> > number of times a percpu object will be allocated. Calculate this
> > in test_vmalloc.sh to be 90% of available memory or the current
> > default of 35000, whichever is smaller.
> > 
> > ...
> >
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -57,6 +57,9 @@ __param(int, run_test_mask, 7,
> >  		/* Add a new test case description here. */
> >  );
> >  
> > +__param(int, nr_pcpu_objects, 35000,
> > +	"Number of pcpu objects to allocate for pcpu_alloc_test");
> > +
> >  /*
> >   * This is for synchronization of setup phase.
> >   */
> > @@ -292,24 +295,24 @@ pcpu_alloc_test(void)
> >  	size_t size, align;
> >  	int i;
> >  
> > -	pcpu = vmalloc(sizeof(void __percpu *) * 35000);
> > +	pcpu = vmalloc(sizeof(void __percpu *) * nr_pcpu_objects);
> 
> Could have used vmalloc_array() here.  Otherwise lgtm, thanks.
> 
We can also reduce the default number from 35 000 to smaller one
since this patch makes it possible to control it via parameter.

--
Uladzislau Rezki


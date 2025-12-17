Return-Path: <linux-kselftest+bounces-47668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4780CC8A7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95A5131B7CFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B934FF6A;
	Wed, 17 Dec 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca2NqY2Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="spwPvRAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F99355030
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986556; cv=none; b=dCYv0Pbpr/+NHSIASYKMOKjVf3qZS1wpjwf4ZV8D2c4yy6wHm+uCNREg4HHCnSCiPZ39umw4K2tiPSXKwWhm+E1wWRP5ZPFWoRlU8l2uabunUdedawZb5J1K27cQXIrbF1b4b5GLz5HIDsizferEyFGChsWPHhG135YvD8WEC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986556; c=relaxed/simple;
	bh=ej7TTVTeGnBUqaRwlQnvTPhYft8GTVTgUYErJC5s1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+fV4+rbozDdwvnpjS6a2YHtGYxicloLKhrQTFOHpNSPLmKjVWwDd01TGoIB1O1GVS7EssFi4NqHAedv3T+DvIgj1SqtdKaUvudHMtDwebXtEcWEwjsBkSUo2/m1iarbINW0WaK38d9roXd/ImKXthKn+tkDyVPwg+465medRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca2NqY2Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=spwPvRAV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765986553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
	b=ca2NqY2Z+LsZs1Ai3rL7BxhuR0P9r0LDGgzf1c3lMXkjAipVXBAT0tgEFSBvOJqaI9639N
	ug+UWYM8582plrwrTWTejdI/rxBcIdDwgy+LeD1e3g43HCBPzvvDxnPdnW9UgWnAN8nswh
	uiA7vbyLDBnF5M7Yg52yn1M1rgmYeoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-ls-5XNMiP-GsRl-bSXBJ6w-1; Wed, 17 Dec 2025 10:49:12 -0500
X-MC-Unique: ls-5XNMiP-GsRl-bSXBJ6w-1
X-Mimecast-MFC-AGG-ID: ls-5XNMiP-GsRl-bSXBJ6w_1765986551
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4788112ec09so43475965e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765986551; x=1766591351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
        b=spwPvRAVjPd8bAiYboWPfTfdFQRAGJ15XAMwYEoFXDhSZefh54e7XdccsV5Llc7Uwn
         2Cd4aUsk59IcNoYtlvXaU1Mi6aoRLHZ6uAPodYzH5JRhyfmUM8GEM4l0xNB9+tAy0zub
         9SZNiNhKId5RxSxLB6gIRe5xfrR4+KiqLBLzKPse1zd9s95n51KT6b8aIR/UGNVPf9Kn
         qmT2ZrxAaWp6fQhFzYdNQuC8YE+2Tqtl8upLZ+fN/gbKh/DUqQXaAP9Kqtpts0PYOwHq
         uEJvmQTonCLkfKmsTyfZODQI1KNnPHzW0oRFGVH2haIcbyNlOlIV8Fu6orjabELdfyFz
         FX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765986551; x=1766591351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
        b=e4OKWlyNDjUPOyUjwoCbO3yDcA3Pr3F051cEagMq0dadi1Guq4TDjGNSfzJ6YqClyH
         3hmHbmZZh18zpLcVUyrSBPmgo8oXKmOkvyNqlABS9dAMYWch76jkOLO71X2y2Sc9R6qA
         nrxNuH8SyKdgdCrvoVgC9brclmQC1pK3LS9j9B9RBaxKtt0thFrf+lxpIxy6rhIvucrB
         irlvtwGjh5iHpsmskBJ8vRIGusFSgyD8yRodsH70Z+h5WiPPRljnrufR5nt4FJGVSpc7
         FqJT0K1zVsDVwjdiCACLd4r7Clr1eaUXPsvFbQPMwQwnGQij03Sdra/3G9u4PKwb7Ecg
         wU4w==
X-Forwarded-Encrypted: i=1; AJvYcCU8IWlDwK628ap6kn1CRnCV+0vFpVk6w/INSZZauTdk3EkW91EU7WwS/LZ9lh7DnKq+472DjCIGQOuVnvDDbOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09JT4jNQl9hrKen/lUCDJQ4KrCQO+tOPznOTSs0b3MosycJOu
	f3dGrXr6s+/Rn9A+UJBS/UUCl0lSyhQesoq36AioxQgel+woGvDMoty62YLJjuohGzb5ln29Faz
	lMGiAeT/pBCwahD4qf8W0pg/Gvzu+rDjLFn/BYnsl+OwOyzf8Lf3BciCulncxcA1F5W8zpw==
X-Gm-Gg: AY/fxX5wElPsyYjeVEFjmYjIQD9ZeJgB77f8XJ2s5DAmc0uSnBJvG48Cc8kUF4CNf33
	GOIB/UA/PEPdBhGq4ad3TCpXNeJsFiAXNxBX53e4K7gWy0WUvEm4jMQIMP8xV0Vx8GtleoJmCJb
	w/sU/WACK5idAIHECOjmMfqINIBWBg/1zl0KS83g+oUlTltoKwG6kiPoXpiBQbzOmYiO1YsSz5U
	R4C+bLMJtQ4S/sQZdlALhYzP0Zahkae9Pv1inLmNHBhTbfWkYqCCu++Aon4BNpeHAIJ52n6EoHO
	XLvVkF/HkWzXjVbsZfgCj3A/t7zsk0L0yNsBLinQ+hT5ljGjFoyZHzSNP1JAOFXaqtmJ0zM5V4J
	Ftk1AEO4XQouGhcej4aqVF4l4ZGWskV9OM2iUxGmh
X-Received: by 2002:a05:600c:1c88:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47a8f917533mr206283905e9.34.1765986550779;
        Wed, 17 Dec 2025 07:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ+ughGVWwzvXsaWm1dblcs5eRzcKirhAt+kak2tJQKEnBlZisL9+a1O+Ahuhxi1HwalxGKQ==
X-Received: by 2002:a05:600c:1c88:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47a8f917533mr206283615e9.34.1765986550400;
        Wed, 17 Dec 2025 07:49:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd911a9bcsm32202995e9.6.2025.12.17.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:49:09 -0800 (PST)
Date: Wed, 17 Dec 2025 16:49:02 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217093923.1556187-5-arighi@nvidia.com>

Hi!

On 17/12/25 10:35, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.

...

> v4: - initialize EXT server bandwidth reservation at init time and
>       always keep it active (Andrea Righi)
>     - check for rq->nr_running == 1 to determine when to account idle
>       time (Juri Lelli)
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)
> 
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> @@ -3090,6 +3123,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  {
>  	scx_disable_task(p);
> +
> +	/*
> +	 * After class switch, if the DL server is still active, restart it so
> +	 * that DL timers will be queued, in case SCX switched to higher class.
> +	 */
> +	if (dl_server_active(&rq->ext_server)) {
> +		dl_server_stop(&rq->ext_server);
> +		dl_server_start(&rq->ext_server);
> +	}
>  }

We might have discussed this already, in that case I forgot, sorry. But,
why we do need to start the server again if switched from scx? Couldn't
make sense of the comment that is already present.

Thanks,
Juri



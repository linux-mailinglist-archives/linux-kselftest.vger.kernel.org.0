Return-Path: <linux-kselftest+bounces-28251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88598A4F16A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80FA3A6F8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 23:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FF278164;
	Tue,  4 Mar 2025 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g47bFCX2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015D27BF63
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130686; cv=none; b=AwCdlxpDryVy4U8p8/6B4IUpIPVL0cfEq8Ezy6BktRGl7V3SDCZxv5FaxWT8jEafirKpl+pEIT8Yt/MRwZjC3W5JRlppmjF+RKYYyrJtRhVfXLgXuM2R/jK8ximI6eZwoQtnwIOZgS4c1KNiXD7jFsm420JjA6vvaiaZtTsRV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130686; c=relaxed/simple;
	bh=ft4BPe47zhRld0rPUuffwsZAusYgbs12YAc92bs01Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYbnfvtYS2gZMjklu2V5b5eqL/ig1tEgYleCh8whwN2RZ+gfMlt3cgS9ll1aP67PiFBt9o6ya0I7HySEvuQqzOa8OgPwTWDTivh1AC+rue7kHiwTxlgRIZpq5aja39ik6V0Q1HerLyQH1qYcFSFaR8t3xGpNOzz0XxA9C3YOnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g47bFCX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741130682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srEgUoPvUOjlJVSCl5jmznUtYK/BU6V0NKB10e7D9Q8=;
	b=g47bFCX2Qad6UGEDhwTGIW2UKQEpE06Qt/8B2ftZtesGZ0su8/f9HvuuCU1JidTUWiDyfs
	o19KBGOvKK88nkYX9SbtCHM8HN1hyKzLa2yInlgxI9rOSnF7qgBrW8GlJ8PORMO7Eh+lEA
	evmOpUQne8+6otvTZkjyBCcoM4BgCgQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-W3ROTuyJOb-NOD97o-Q_oQ-1; Tue, 04 Mar 2025 18:24:40 -0500
X-MC-Unique: W3ROTuyJOb-NOD97o-Q_oQ-1
X-Mimecast-MFC-AGG-ID: W3ROTuyJOb-NOD97o-Q_oQ_1741130680
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0c1025adbso1544546785a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 15:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130680; x=1741735480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srEgUoPvUOjlJVSCl5jmznUtYK/BU6V0NKB10e7D9Q8=;
        b=qz2ayFoy4vc9dZs2D4CKrSO9zw30CRGKRBElLyAVuMZlO9Z/PVr7U4bJ9Kw0UyaFnh
         4KkyNQiQ2GKQotftwJwQ8SitdQg/6cNdWI4uXgxXT1gkChgPqDqbgG4a0BrXUfOJI5nw
         6mibA8FxuhM1MHr086wYV3+gY4ox4a5Jo6n52GNHUwRXrH4Oua+Om/mA18mjZUy0Bpny
         Hi+h9jh+gwFFbW5TdE0CFbKhKbpGLVCCFzTc6o0EnsRc8hNasp5LmFAfIqvQHtekY2V+
         oDJKrIBS4hrnbj91/uBQYUH4oVlCWsFtHt0THv8oD6KZrd8J/BxTp/gwWhByOim7pj6g
         BJvA==
X-Forwarded-Encrypted: i=1; AJvYcCU7l+Gj/DFARXulAi/rsh8fLW0vHBB8EkJEO5bCsNNcliQWXdB41PN1m848Q8rXWK0HQfZUH/HvymOw5dK/Zy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iz+Enix11r11Deadd32xVy5o5U4K7UKRFqrpL0LbX37u53RI
	L1oUt+oQaWvHSdIP1OrXKsXHnYFp9yZIz9Ge7neDlz4GoIhdDPG8YHeOZCWy66ADeIbqSzgQu1+
	pOwZTh4mR8FI+kSzEiYk4HOw7zIXFWkNmZAmmLhJQvV5GufGRmymzVoba/fHCnP+cGA==
X-Gm-Gg: ASbGncuFEboAEPyHIMEQX3X1+L+LQOQWIMBvsK708roKJR9VBOwbfRmr9O9mUiIW7Mg
	Q4t9XWnV9yoNdQc+e4+949kOFZUYKTMiOzRNxc40t8gqWrfoL72gvMvKloVuUTsX1nLGMM6mTcj
	al4eUVqj1FnVwJJ6pcqxKwgLub5c9eElPOSXiubgjXm+4tUtu1IKHY7qzi4wthWXtHtzke+822O
	DuMf7/dDVSkfI/Vc91bqzeeroLHs5Qj5t1oHYNWfe6cWDcRgPI2/Vls/7tvPGdIJ0/5lMyXCbuJ
	2t+tkaU=
X-Received: by 2002:a05:620a:4c81:b0:7c0:bad7:12b5 with SMTP id af79cd13be357-7c3d8ee13demr168820885a.54.1741130680391;
        Tue, 04 Mar 2025 15:24:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6MzWOSSNkUTEXlvQ9iJOjQzvGjjEFVSlf2ZUpEyaz6kgQfPIR8TZfY2WcFT4CY7XBnhBEjw==
X-Received: by 2002:a05:620a:4c81:b0:7c0:bad7:12b5 with SMTP id af79cd13be357-7c3d8ee13demr168819085a.54.1741130680145;
        Tue, 04 Mar 2025 15:24:40 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c3edff13sm266678485a.69.2025.03.04.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:24:39 -0800 (PST)
Date: Tue, 4 Mar 2025 18:24:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd
 files
Message-ID: <Z8eLs-53UwKHfEeK@x1.local>
References: <cover.1726009989.git.ackerleytng@google.com>
 <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:58PM +0000, Ackerley Tng wrote:
> @@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	 */
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> +	/* TODO: Check if even_cows should be 0 or 1 */
> +	unmap_mapping_range(inode->i_mapping, start, len, 0);

Should be s/start/offset/ here, or should expect some filemap crash assert
on non-zero mapcounts (when it starts to matter).

Btw, it would be nice if the new version would allow kvm to be compiled as
a module.  Currently it uses a lot of mm functions that are not yet
exported, so AFAIU it will only build if kvm is builtin.

Thanks,

-- 
Peter Xu



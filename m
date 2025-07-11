Return-Path: <linux-kselftest+bounces-37127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72236B02095
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FB14A8672
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355D2D9798;
	Fri, 11 Jul 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5uDvkop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28B2BAF4
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248282; cv=none; b=Nhb2cmB1o/gQ5nAu+01MglC0zv/ZPh90F8/BIfCc1J877FC6+twVOfqnk9vGSNWQXd1nb4ysbKWam1VaGpnqBE43ZaYldrys6q6GpkrWOwF+qgWulP7oiOPwtQ8YamlYVESRYFQCcrpepxbFx5E0vgbM5frmLHeOnRh0g17xgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248282; c=relaxed/simple;
	bh=J1TQlEBpErPT0lubagiCxGKuVyYl7P3A+G/37YC0akg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfQilOSKwT/HPFnOgJqWH7T/ux29npMpmBLFlBHAK5TxCeRDuoO0DcvxNa5fWjV4WGy3c3bXX/AwaTwIJ/JZcMMWtjOkD/VR6Y81TOgCIRoB54SrzMMnID+HFHTtvGUjSAwIYGVlDl6J3Cgyv7qblqibmmMcZTi9AQyNw9uCjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5uDvkop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752248279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VW10s4xSbWS++T0PM2JylkU43RRqz5v3WojM9W8P4jc=;
	b=C5uDvkopGTBmG8JC8+rGyeO4m4GkOWiRN0q8FdqCzknDoH+9LhLHCceGw4SQwO71wdaEGg
	4rotjD7cE8CghN2AO0xD+ao56C0gSF0LJ6QMrSfrjkPDTlHNs+br5BvTU9vZsjb/2U2nOZ
	JVPPF/nZetFfg/5Qcndb6TWRYD580DY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Devi40OgNE2WKqhy158FfA-1; Fri, 11 Jul 2025 11:37:57 -0400
X-MC-Unique: Devi40OgNE2WKqhy158FfA-1
X-Mimecast-MFC-AGG-ID: Devi40OgNE2WKqhy158FfA_1752248277
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so905999f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 08:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248277; x=1752853077;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VW10s4xSbWS++T0PM2JylkU43RRqz5v3WojM9W8P4jc=;
        b=gAt6GijF1NypaGvizk4IY+sqXbkJyHT0c9ClSfGFM5kzcRcxvhAwiKmoWVsypnMj4I
         ITYCIJp/cxDPWNgnjxtuyrPPRkaqYhCVeFfWKXAoWTwXVzkgas9abFkPOlEG9yYms1z/
         mY1JGuAmJv4w9NzmLdgwLjJKQsyemooIZ5Kqpr3X64WbMdS9ykgl+nQqSIMhSqMnXMN1
         i7JNittSRzEqHtu0GMu4kkLgINfkmFwRMKPbCcHg35rxSiqV6OdZ8PxrHuB2Lo4+DidH
         ow2wM7lbX3kNJ3z7noe9r2P+v+sP1tM1JLo7+XaVvEn8h4Hr/gEVtDZfeCy+9qH6WMfP
         dGCw==
X-Forwarded-Encrypted: i=1; AJvYcCV6n/f1VMAkef9L4GXQghYgtzLSRtdIRZh0zdu7U+X31KUuUjAsPS29v8yVs9i7k3pLITFaEAXXz9mVM/cVXAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5vruwV+LgoLF3uf+iqGEM/TGHjTNFgSiQWbc1E3eGi556l89
	ZDcUiXyudVmSaJNIWDxreGWtVGHCaRCIXMecNwDFqS6wOkIH0zXYY0DqvAkk6uBB88qsEmwF7NC
	PB+Ih8eD6L20EfGTnfjGlWXNHrFUgex9k+5j/0/5NcqbwDeRd5p4EMrsyCTtSSL4UY30wmQ==
X-Gm-Gg: ASbGnct3kkVEC1AKksRYLwBC8qlzCwDm8Jn8h9l3NPHXIlYjfDcy9b8PyG3aSpUFlx5
	hVT+o/m2YRPCaZ/ZJ170v8v2SwxeKgPVbFJggdHve4aBOfa7BBGx3Wz7A/poicP+j0gDC1MZt1l
	z25WJKYCiIV2tsTxxaT6SFZUcBrhI5a6Ef5223Kva+mvpC1rTMzNxbdRWtd3FxxViR3JpPBzxBW
	JVt1ls8KqFr4FBQlviivHFufXBCbZaLYqEDRwANHZcVp0oHZ4ExJ+WPLhSPH5f0nJjBTrzPFZLA
	APGyxSOPB9W03G+6i4YJt9AT6v1MPOtWckWy6sc2VOtnxkGxFDkYIae94sok8Qcz63/SBSwcj6d
	1vuLkhrWvhDYh6/Nb5EQWdJIPGj0P/TS1r6Gd6tfupaeayptCudqWVldOu6bYzDEgf3Q=
X-Received: by 2002:a05:6000:430a:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3b5f186ed56mr4041286f8f.26.1752248276615;
        Fri, 11 Jul 2025 08:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsuwcbyEVKhe8empXAIldfyKwdlIf8zNcDa9WQWEBE8Mfskb+P7pj/L+LuE9MFlS//F4Vr0g==
X-Received: by 2002:a05:6000:430a:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3b5f186ed56mr4041258f8f.26.1752248276155;
        Fri, 11 Jul 2025 08:37:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d727sm4812998f8f.51.2025.07.11.08.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 08:37:55 -0700 (PDT)
Message-ID: <5f7f1281-c75e-4cfe-b51f-8d6ed001200b@redhat.com>
Date: Fri, 11 Jul 2025 17:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch 1/2] selftests/mm: put general ksm operation into
 vm_util
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, riel@surriel.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, harry.yoo@oracle.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
 <20250604082145.13800-2-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250604082145.13800-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 1357e2d6a7b6..115422e9eb68 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -486,3 +486,74 @@ int close_procmap(struct procmap_fd *procmap)
>   {
>   	return close(procmap->fd);
>   }
> +

I think we should just let all these functions open/close the fds. So 
there will not be a need to pass in the fds.

> +int ksm_use_zero_pages(int ksm_use_zero_pages_fd)
> +{
> +	return write(ksm_use_zero_pages_fd, "1", 1);
> +}
> +
> +int ksm_start_and_merge(int ksm_fd)
> +{
> +	return write(ksm_fd, "1", 1);
 > +}> +
> +int ksm_stop_and_unmerge(int ksm_fd)
> +{
> +	return write(ksm_fd, "2", 1);
> +}

Can we make all these functions return "0" on success? This, way, the 
"write" will be an internal implementation detail.

E.g.,

int ksm_stop_and_unmerge(void)
{
	int ksm_fd = ...
	ssize_t ret;

	...

	ret = write(ksm_fd, "2", 1);
	close(ksm_fd);
	return ret == 1 ? 0 : ret;
}

> +
> +long ksm_get_full_scans(int ksm_full_scans_fd)
> +{
> +	char buf[10];
> +	ssize_t ret;
> +
> +	ret = pread(ksm_full_scans_fd, buf, sizeof(buf) - 1, 0);
> +	if (ret <= 0)
> +		return -errno;
> +	buf[ret] = 0;
> +
> +	return strtol(buf, NULL, 10);
> +}
> +
> +long ksm_get_self_merging_pages(int proc_self_ksm_merging_pages_fd)
> +{
> +	char buf[10];
> +	ssize_t ret;
> +
> +	if (proc_self_ksm_merging_pages_fd < 0)
> +		return proc_self_ksm_merging_pages_fd;
> +
> +	ret = pread(proc_self_ksm_merging_pages_fd, buf, sizeof(buf) - 1, 0);
> +	if (ret <= 0)
> +		return -errno;
> +	buf[ret] = 0;
> +
> +	return strtol(buf, NULL, 10);
> +}
> +
> +long ksm_get_self_zero_pages(int proc_self_ksm_stat_fd)
> +{
> +	char buf[200];
> +	char *substr_ksm_zero;
> +	size_t value_pos;
> +	ssize_t read_size;
> +	unsigned long my_ksm_zero_pages;
> +
> +	if (!proc_self_ksm_stat_fd)
> +		return 0;
> +
> +	read_size = pread(proc_self_ksm_stat_fd, buf, sizeof(buf) - 1, 0);
> +	if (read_size < 0)
> +		return -errno;
> +
> +	buf[read_size] = 0;
> +
> +	substr_ksm_zero = strstr(buf, "ksm_zero_pages");
> +	if (!substr_ksm_zero)
> +		return 0;
> +
> +	value_pos = strcspn(substr_ksm_zero, "0123456789");
> +	my_ksm_zero_pages = strtol(substr_ksm_zero + value_pos, NULL, 10);
> +
> +	return my_ksm_zero_pages;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 9211ba640d9c..99c1b1aa1813 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -95,6 +95,13 @@ static inline int open_self_procmap(struct procmap_fd *procmap_out)
>   	return open_procmap(pid, procmap_out);
>   }
>   
> +int ksm_use_zero_pages(int ksm_use_zero_pages_fd);
> +int ksm_start_and_merge(int ksm_fd);
> +int ksm_stop_and_unmerge(int ksm_fd);
> +long ksm_get_full_scans(int ksm_full_scans_fd);
> +long ksm_get_self_merging_pages(int proc_self_ksm_merging_pages_fd);
> +long ksm_get_self_zero_pages(int proc_self_ksm_stat_fd);

With the fd parameters removed, that interface will look quite neat I think.

-- 
Cheers,

David / dhildenb



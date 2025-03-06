Return-Path: <linux-kselftest+bounces-28406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5DA54DFB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 15:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37941896DBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A616A95B;
	Thu,  6 Mar 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2kxRx2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D515DF71
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272042; cv=none; b=LH0s+MChIEnp0wTKFbUuSrSoiBA+uEQJY+Fuv+RWWqmmfhDRaeIb+Pu7dDMRhy4daIxZsPRqe+U5e6vIyUmFwTv3B7pKtVvSslA4v0wJAGN+2nsL6x86uhC5Xubl5cLvU2n16LW6TmBMWr5ZQuWzLE39M8XJWWZu8+P0XCREXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272042; c=relaxed/simple;
	bh=wwYqQW/9+pnmhpksAkKV19mrhqTbNNyfzn1mtaz6zlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mcux2un8DSpCn0lD3erCpVGvBDCeL1Tna8/WtnJjkRE+yywTIZ4cpW6lFFsOziyu8+sQeq3ERX3kXIcYMoNiH0QwO6ONR3cJYuGxZ0R6NCPMSoW9veLz7Gav58fdRhgYk6zsRS7D99H5KuIfn+pHs/IsEBk7aoIR9XEESGKEgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2kxRx2o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741272039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pRXqlMTO8KnZMf65hCtbEVZBgewx/3LqEuRqTciOKdg=;
	b=c2kxRx2oXEtQv3/PrCl7+baQ99kjVtukuyqthf2cuE3ARe8n1NcySh5hF4SKz/rdbjC+Vr
	43ls5NNtBWV2ecAsSCq4pqUNXXjv30RxHk3D4Hh7JfymzN/yxydgM5rPy4UxuHOCCDwXAc
	x7rXzA36IfrT19wLfENH2voA+xdHeWw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-m5AWEMcnN0ePUvbjeHwWwg-1; Thu, 06 Mar 2025 09:40:31 -0500
X-MC-Unique: m5AWEMcnN0ePUvbjeHwWwg-1
X-Mimecast-MFC-AGG-ID: m5AWEMcnN0ePUvbjeHwWwg_1741272030
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912b048ed2so398708f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 06:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272030; x=1741876830;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pRXqlMTO8KnZMf65hCtbEVZBgewx/3LqEuRqTciOKdg=;
        b=eHbEdVCT9R+nkif8wxptcjYhVPK4/YV+bWDDSAxvmAklwZPyy3j4yusn4z4YvDB0/t
         LJLmTkYE95Qbk0HODEdCJOTfAZpcs6/0oHi6ZUaEBg2coMj0KQnMZZOc9iudbg9VXRzh
         qa+BM2Wa3SPSgh69o62zRVhWQWBmcrGJWa5yllUcbDCXAxMSJNYxxQZlAgCbx/eQe6U9
         7VnVvfDaJoRVUJJ3IIyxiOwUFJhfzlxmUQPOGsz5Ddu98hx/82WWlFvlTWBDmqB7yQ8l
         hr/60qdkdC6HypVUvawyjvSvK6PnFZAmbdmw6iTEsh24eOoFAFv9UgFX2y9gPhs848o4
         6bMA==
X-Forwarded-Encrypted: i=1; AJvYcCU5s6xJbf1J67oqAicRHOkciOddr/xVA/7oX8xEC4a6svh3k2ddcR6kLFCfwKDoyWn6QqNQ4ZGUQ3z3DlrMRY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezYYRmtoQWRnCIrIHD17/OkCIdq/anV+pXLhisTWEZj9JNJ3o
	HtcFZejtH6xlMXJcU4be29i0zXFCMW7rJR4sqS6gKLi4THKJ819wR2aUBTEojwYwc/7ujh2JFoN
	rUAQXyfmgDHYZVnT93smHuzoO1FAJzORul2eTireFouK1BGeYbzmx10p/WkLFo3vtuA==
X-Gm-Gg: ASbGncuSVbI5uX6xlaN5IKWhXOAIz5shVrKYz1VvsyHOkjf9UrFYgn9BbZWR0lYhldQ
	02oEBxtN/QxlpIE+X10LAeUvL1LayTUm634pyVguwJtr08JLRPlrjqCyXsgkFkt0z9gSQ+lK4eb
	yhRq1Me/RFM776fb0grxd19dqjOKgMEyTMlvkBnLOrbXq+tnGm1sUzQEMK2RowG1y1JkGj5k3lD
	VdxPPBhKUSD3lHFWHseJfnohS75GqxMnEHxKxbapo35tosq2fyVFW2mZSvOz1NvTD80i5+N7O4G
	zbHMkvXAmk5sZTHUhIpPmbh5fsQc3Rja2IaksaWvE4/8WiQBfrbioIBS91hRownUZGqm/hNs9+4
	CSTYFfcMuCwNJgA1xvrjZwcxb7O+2uTXJkOTQ2yqJ5L8=
X-Received: by 2002:a5d:47c2:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-3911f714d5dmr5314938f8f.4.1741272030012;
        Thu, 06 Mar 2025 06:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtI9mMXBhwkIi8UD8ii9/+uMbYJ6GObW5v/10syJXLcZpuCccFfu+VuAtQ9RJ18+4Ew3Hd9w==
X-Received: by 2002:a5d:47c2:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-3911f714d5dmr5314921f8f.4.1741272029577;
        Thu, 06 Mar 2025 06:40:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2bacsm2239129f8f.78.2025.03.06.06.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:40:29 -0800 (PST)
Message-ID: <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
Date: Thu, 6 Mar 2025 15:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8mYG8eQnMsOA4c1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.25 13:42, Brendan Jackman wrote:
> On Thu, Mar 06, 2025 at 10:28:09AM +0100, David Hildenbrand wrote:
>> On 28.02.25 17:54, Brendan Jackman wrote:
>>> Some filesystems don't support funtract()ing unlinked files. They return
>>> ENOENT. In that case, skip the test.
>>>
>>
>> That's not documented in the man page, so is this a bug of these
>> filesystems?
> 
Note that I meant that ftruncate doesn't mention this in the man page.
The only occurrence is

"ENOENT The named file does not exist.", and that only applies to
truncate, not ftruncate.

> Um...
> 
> unlink(2) does say:
> 
>    If the name was the last link to a file but any processes still have
>    the file open, the file will remain in existence until the last file
>    descriptor referring to it is closed.
> 
> And POSIX says
> 
>    If one or more processes have the file open when the last link is
>    removed, the link shall be removed before unlink() returns, but the
>    removal of the file contents shall be postponed until all references
>    to the file are closed

Right, it's supposed to just stay around, it simply cannot be looked up anymore.

> I didn't call it a bug in the commit message because my impression was
> always that filesystem semantics are broadly determined by vibes. But
> looking at the above I do feel more confident that the "unlink isn't
> delete" thing is actually a pretty solid expectation.

I have a faint recollection that 9pfs is problematic with unlink ...
and indeed:

https://gitlab.com/qemu-project/qemu/-/issues/103

I'm not sure at this point what's expected to work and what not with
9pfs at this point.

> 
>> What are examples for these weird filesystems?
> 
> My experience of the issue is with 9pfs. broonie reported on #mm that
> NFS can display similar issues but I haven't hit it myself.
> >> As we have the fstype available, we could instead simply reject more
>> filesystems earlier. See fs_is_unknown().
> 
> Oh. I didn't know this was so easy, I thought that checking the
> filesystem type would require some awful walk to find the mountpoint
> and join it against the mount list. (Now I think about it, I should
> have recorded this rationale in the commit message, so you could
> easily see my bogus reasoning).
> 
> If there's a syscall to just say "what FS is this file on please?"
> we should just do that and explicitly denylist the systems that are
> known to have issues. I will just do 9pfs for now. Maybe we can log
> warning if the error shows up on systems that aren't listed, then if
> someone does run into it on NFS they should get a strong clue about
> what the problem is.

Yes, just skip 9pfs early, and mention in the commit message that 9pfs
has a history of being probematic with "use-after-unlink", maybe
mentioning the discussion I linked above.

Maybe something like this would work?

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a614..349e40d3979f2 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -47,6 +47,16 @@ static __fsword_t get_fs_type(int fd)
         return ret ? 0 : fs.f_type;
  }
  
+static bool fs_is_problematic(__fsword_t fs_type)
+{
+       switch (fs_type) {
+       case V9FS_MAGIC:
+               return false;
+       default:
+               return true;
+       }
+}
+
  static bool fs_is_unknown(__fsword_t fs_type)
  {
         /*
@@ -95,6 +105,11 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
         char *mem;
         int ret;
  
+       if (fs_is_problematic(fs_type)) {
+               ksft_test_result_skip("problematic fs\n");
+               return;
+       }
+
         if (ftruncate(fd, size)) {
                 ksft_test_result_fail("ftruncate() failed\n");
                 return;


I am not 100% sure if V9FS_MAGIC is what we should be using? "man fstatfs" lists
most magic values.

-- 
Cheers,

David / dhildenb



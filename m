Return-Path: <linux-kselftest+bounces-47824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03320CD5B1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24D7302A110
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4730BB94;
	Mon, 22 Dec 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/t4Pb06";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn0ZgfGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3332243968
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401028; cv=none; b=AJJ+GzblEeYlzhScO4zMqjZbJVrBDRHpyovAZGFbH8bF4oP5flqUhWyRnvw3ZhDPOhzBNDWY4wJ8XhTL75cLZkROlw3qHiD7bGj7EoPBeO6L0n4SViqdMX5rMHnk+9/cvuN4V/4GkYYzYivX4fkic6B3Iu1Dhrg46kgWdrYNGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401028; c=relaxed/simple;
	bh=978mP7PKse43IyZIZgjWeKcvZ5+A2ow+xshzpeGvx7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCYLP0+lGFEjEWUpeixGhn+YO/LOQmSLAeiPtM91tc1o52xyMVP8XB486C7QziNNn6zFRwcitZK99qAYWRlybXzz0cwu9P1u4symAJp5dyUw3vA/viP/jqLJpXcAXoHsVWP76+e6Y3OifqPGg0SF0P/nZ1FSoVudP0hgJ5m6wAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/t4Pb06; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jn0ZgfGX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766401025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVaLeh7HdWjqionAuyu2RoMDiu82J2XaxH32QozT0Tk=;
	b=U/t4Pb066IRgM7wc/eIE8xG2yOVAml0iyAPs6FdYFEYGMRCo/wwGo1CTglWuRLK7YmIFfq
	BU5YQ3xg/jqX+NaX+RbL/yZPZ/Pp2lVkVS+cflLOs6LFzt//ImY/FKsw6x7VsiaQ85yl2c
	Zxk0vlLf1DnSZKyUSZqtgdjtPo2EfeU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-oQMwmIgcPrqlnhRJxhgd9A-1; Mon, 22 Dec 2025 05:57:03 -0500
X-MC-Unique: oQMwmIgcPrqlnhRJxhgd9A-1
X-Mimecast-MFC-AGG-ID: oQMwmIgcPrqlnhRJxhgd9A_1766401022
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so3977931a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 02:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766401022; x=1767005822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YVaLeh7HdWjqionAuyu2RoMDiu82J2XaxH32QozT0Tk=;
        b=Jn0ZgfGXmqS0L7gdQmr5FNvBm5j7Sk+BtivudKlvxYlxnuP+k5GOoS+QHl6wxjCBiD
         YUFN/QKWqmB01MakyIEZJO6rdTr7ONP8otdnoUs6Et4HDS9D795RygcCBFhFYrXbm+hR
         snqllVH7tB72eE2EH1Xnn45LeQNqP/3d3Q+9FRcKVhZXfUwscOirGyuQuAwPNWRyoA/5
         VBflWv/Q1KqYiqMUhKMzhjPiscV5jeFYakfBpELZ+3PwWkuao80mdzzMTz9WjI28BGz8
         6hZ4S9WGqpZ3u9VF4VgEmM3HYjK6Enun0HA/En2vTX9AvRhLb9fM1rTLg5Xw4B7pLZsK
         vc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766401022; x=1767005822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVaLeh7HdWjqionAuyu2RoMDiu82J2XaxH32QozT0Tk=;
        b=Eb9U0J/TE5tBMVJapGZDvqGqx5Tvv9NElH9bn7FrfyTewt6egG+C8q3UJPWQEvcNG1
         rQAV0CAZx3fI0X78go7SxFTEKZBAujMcvXWjrggJik92fnZxFgo57UVzaIglD7HbQGgI
         P2UAikBIV7m7PlREOuDOCEGSuhNoilbhV0g7HUqGmIWXLAqbbXmLCjF+2fFNSct3Nfri
         zjjxsnUE0894FUjU3CIzW3XnCLCjLLK9JHaCkK/0aPlg8kZsZy0hGii201yXI7WEmUQN
         eEUJTJ6xnBn1LNZdeQE3QK28h/rVup3bBR5lXlbJ9BQMUrYwef1syKKl9y4fzGlK3dRR
         nFgg==
X-Gm-Message-State: AOJu0Yz4kDeWpMfmP4qRjqJoFead0mY1fl4fd1QnpX6EO3FcHaU5ttEZ
	yKotERs3TOTQGO/1rWhEAUV8Wfw0NkHX021SXUoNKX7hBbNLG3zgOJXtH2/bEul6EDTuQlvEBaP
	OOYC2VEJQyU4sGSmlO4SXpkExrNiBjqboY7swpMaVRI5otsY/lScZkIiGnXULMxuRzcvh1sXlE2
	0qSycMV/Eeb1Gubu+wC/JUggVzJdqir4n1VVK9ThM8sRW4
X-Gm-Gg: AY/fxX6/P0h0GkG1QJQWQ47Q1uUnt3MqaJGUWyCpKDl0NDOl+EWuJnvcFUdGBcKOar4
	V2Hiekps1t7g/WI7UeU+XvXY+3VvRc3xzQfem73STdXw2QxeGVyR7SF5L2/jnG9wDiqLHEQzN0i
	ff4cPucdkNZuNDp2WUNEM1iURxrgjzrKBGtdTLu83sit3zwdhqZDh4gb5zpiAtmhabBac=
X-Received: by 2002:a05:7300:c01b:10b0:2b0:58aa:8852 with SMTP id 5a478bee46e88-2b05ec6d746mr10200109eec.22.1766401022228;
        Mon, 22 Dec 2025 02:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOZ8Mg+irUUx00i70JUySVxbyZwgHrGLx5tvOrAi1bLKJOKaGccjgn0j03pYHiWhdTj5a1Q62kHvVuiw4oyZ4=
X-Received: by 2002:a05:7300:c01b:10b0:2b0:58aa:8852 with SMTP id
 5a478bee46e88-2b05ec6d746mr10200088eec.22.1766401021797; Mon, 22 Dec 2025
 02:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221122639.3168038-1-liwang@redhat.com> <20251221122639.3168038-2-liwang@redhat.com>
 <20251221221052.3b769fc2@pumpkin> <CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
 <20251222094828.2783d9e5@pumpkin>
In-Reply-To: <20251222094828.2783d9e5@pumpkin>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Dec 2025 18:56:49 +0800
X-Gm-Features: AQt7F2rMyTWRAgL_U5eetjBYd2cn7LdFDTq8E1pI5bUehmtEffvK18MPJsl7YCg
Message-ID: <CAEemH2fsAmhAkGAQb9rtD2WLUc7QMb9Q5dusG3S8LsJbNKsO_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as size_t
To: David Laight <david.laight.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

David Laight <david.laight.linux@gmail.com> wrote:

> > > Maybe you could use "%zu%c" and check the count is 1 - but I bet
> > > some static checker won't like that.
> > >
> >
> > Yes, that would be stronger, since it would reject trailing garbage.
> > But for a selftest this is probably sufficient: switching to size_t and
> > parsing with "%zu" already avoids the int truncation issue.
>
> Have you checked at what does sscanf() does with an overlong digit string?
> I'd guess that it just processes all the digits and then masks the result
> to fix (like the kernel one does).

It will truncate the number to the size SIZE_MAX.

From my test:

# ./write_to_hugetlbfs -m 0 -s 99999999999999999999999999 -p /mnt/huge/test -o
Writing to this path: /mnt/huge/test
Writing this size: 18446744073709551615    <---------- SIZE_MAX
Populating.
Not writing to memory.
Using method=0
Shared mapping.
RESERVE mapping.
Allocating using HUGETLBFS.
write_to_hugetlbfs: Error mapping the file: Invalid argument


> It reality scanf() is 'not the function you are lookign for'.
>
> IIRC the 'SUS' (used to) say that this was absolutely fine for command
> line parsing for 'standard utilities'.
>
> It is best to use strtoul() and check the 'end' character is '\0'.

Hmm, that sounds like we need to go back to the patch V1 [1] method.
But I am not sure, @Andrew Morton, do you think so?

--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -86,10 +86,17 @@ int main(int argc, char **argv)
        while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
                switch (c) {
                case 's':
-                       if (sscanf(optarg, "%zu", &size) != 1) {
-                               perror("Invalid -s.");
+                       char *end = NULL;
+                       unsigned long tmp = strtoul(optarg, &end, 10);
+                       if (errno || end == optarg || *end != '\0') {
+                               perror("Invalid -s size");
                                exit_usage();
                        }
+                       if (tmp == 0) {
+                               perror("size not found");
+                               exit_usage();
+                       }
+                       size = (size_t)tmp;
                        break;
                case 'p':


[1] https://lore.kernel.org/linux-kselftest/20251220111645.2246009-3-liwang@redhat.com/T/#m5a5765349dedfda1ed66c54b8cab7af184bff371



--
Regards,
Li Wang



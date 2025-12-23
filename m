Return-Path: <linux-kselftest+bounces-47904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE4CD7CDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECD4830038E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834625B31D;
	Tue, 23 Dec 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NHw7z6Jt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42511D63D1;
	Tue, 23 Dec 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455510; cv=none; b=OLYjxRagM6WkUNW7huxfR7G7jj42Qo8AdbG8XkHYUeF91MG/+xk/bKzRRdE5BCKNfuGOF3YBlFf/2VslXQc9lCVKc4Xxea+x0sCtO9qEWWXAFJ0NLyowMKoipiA2o1PkBniF3PPAkrLvh7Nqvtn5E0Bixeqad1VqnCNArbxl/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455510; c=relaxed/simple;
	bh=e9e61v4L5W1hIaja58wwlVt7sMty5BKmsf5jUCpyDDg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c11oNPQrh4TgOMJrGkZd2WFid+8bT8p6E10H50DsdiE+XEniAlnQ5MODiDyMTyqxVhYIRIYU8H3NedIppR/qdDmpuvq3VZUMR4ksLPPHS/alWEihuGu6k0QmMp6T3ldOC3bbg4qgLKujfZARHPaQt7stzld3vnWux+4UpUHxLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NHw7z6Jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C943C4CEF1;
	Tue, 23 Dec 2025 02:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766455510;
	bh=e9e61v4L5W1hIaja58wwlVt7sMty5BKmsf5jUCpyDDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NHw7z6Jtm0S3j/LisGOhusIOB9ZWtoB7YVtGXxeqY83Gc6054WhFtvzuGmLL3ZTbe
	 5ngHxfyZ/FU9nu0R/x+AU+XXKLHfKDkUh1XsFGcB4EkXa6iKRVh6cE5Lcj+5yinfJt
	 XL/HqBb2TkAhOIhpDiv1DBK+dVaZqKTweNqdg/jQ=
Date: Mon, 22 Dec 2025 18:05:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Wang <liwang@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long
 <longman@redhat.com>
Subject: Re: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
Message-Id: <20251222180509.b12684e112195ac3f7ee9389@linux-foundation.org>
In-Reply-To: <CAEemH2fsAmhAkGAQb9rtD2WLUc7QMb9Q5dusG3S8LsJbNKsO_Q@mail.gmail.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
	<20251221122639.3168038-2-liwang@redhat.com>
	<20251221221052.3b769fc2@pumpkin>
	<CAEemH2f40t+4SsjL3Y=8Gid-CBMtf3eL1egsPKT1J_7LDbdWPQ@mail.gmail.com>
	<20251222094828.2783d9e5@pumpkin>
	<CAEemH2fsAmhAkGAQb9rtD2WLUc7QMb9Q5dusG3S8LsJbNKsO_Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 18:56:49 +0800 Li Wang <liwang@redhat.com> wrote:

> > It reality scanf() is 'not the function you are lookign for'.
> >
> > IIRC the 'SUS' (used to) say that this was absolutely fine for command
> > line parsing for 'standard utilities'.
> >
> > It is best to use strtoul() and check the 'end' character is '\0'.
> 
> Hmm, that sounds like we need to go back to the patch V1 [1] method.
> But I am not sure, @Andrew Morton, do you think so?
> 
> --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> @@ -86,10 +86,17 @@ int main(int argc, char **argv)
>         while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
>                 switch (c) {
>                 case 's':
> -                       if (sscanf(optarg, "%zu", &size) != 1) {
> -                               perror("Invalid -s.");
> +                       char *end = NULL;
> +                       unsigned long tmp = strtoul(optarg, &end, 10);
> +                       if (errno || end == optarg || *end != '\0') {
> +                               perror("Invalid -s size");
>                                 exit_usage();
>                         }
> +                       if (tmp == 0) {
> +                               perror("size not found");
> +                               exit_usage();
> +                       }
> +                       size = (size_t)tmp;
>                         break;
>                 case 'p':

Geeze guys, it's just a selftest.

hp2:/usr/src/linux-6.19-rc1> grep -r scanf tools/testing/selftests | wc -l 
177

if your command line breaks the selftest, fix your command line?


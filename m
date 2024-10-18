Return-Path: <linux-kselftest+bounces-20179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F89A48C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 23:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEAC1C2213F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6318E379;
	Fri, 18 Oct 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LczEJ6NY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90013A244;
	Fri, 18 Oct 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286005; cv=none; b=bfpozN43ESveWFS+Blism9gn/xfo3L5aUWDpdpL0CtDKvCeClP+v8JaDSRZqYl1BLwSVOd01Y2a7ThI98qvvTsovB85tFezoR9dng7/BfhfQRidMp5qGWt9QrX4m4VihEoQ8pLuwVD66x13Q7zf5wEd4PULAAnN4X8PNz7HOLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286005; c=relaxed/simple;
	bh=jX3VATUhc8h3tsVqU5OBxdI1VIgPIxp4JK+Wr7XNrCo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V4vtKpXItdTPIjsKs505lhr/DOoi61dsYyrJmuUT4O6GTfneAyRycSalCA1tw61cDKdQqaou4bS5Z3Qzah3jeTV7q4Mt94aNsw26j6N5wv9pdxOACEz3puhCrAicQBhXGKfVobTRfw7yqP8sUljwbhisuD83CQ975zcRnbT40yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LczEJ6NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C00C4CEC3;
	Fri, 18 Oct 2024 21:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729286004;
	bh=jX3VATUhc8h3tsVqU5OBxdI1VIgPIxp4JK+Wr7XNrCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LczEJ6NYdAxbgwmupa7DRy4M651QwcnmSr6vuwYYHz/sg0V/5zX2BhA/1O1fnIOKn
	 Y7BQo1+v7lSLKfdeW6zJtQjXkth6RW8SdvwwYLzKLSHM6d5S6IKPM0qNLI3MdcZ4uO
	 yk6Pp/2KcPM9ZXz7xl9js9Q+M+NuJm3aHaEi7X8Y=
Date: Fri, 18 Oct 2024 14:13:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Peter Xu
 <peterx@redhat.com>, linux-kernel@vger.kernel.org, kernel-team@android.com,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/3] selftests/mm: revert pthread_barrier change and
Message-Id: <20241018141323.e1c7e0a7312ffd7b92c8f4c5@linux-foundation.org>
In-Reply-To: <20241018171734.2315053-1-edliaw@google.com>
References: <20241018171734.2315053-1-edliaw@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 17:17:21 +0000 Edward Liaw <edliaw@google.com> wrote:

> Subject: [PATCH 0/3] selftests/mm: revert pthread_barrier change and

I simply removed the " and".

> Date: Fri, 18 Oct 2024 17:17:21 +0000
> X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
> 
> On Android arm, pthread_create followed by a fork caused a deadlock in
> the case where the fork required work to be completed by the created
> thread.
> 
> The previous patches incorrectly assumed that the parent would
> always initialize the pthread_barrier for the child thread.  This
> reverts the change and replaces the fix for wp-fork-with-event with the
> original use of atomic_bool.
> 
> Edward Liaw (3):
>   Revert "selftests/mm: fix deadlock for fork after pthread_create on
>     ARM"
>   Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"
>   selftests/mm: fix deadlock for fork after pthread_create with
>     atomic_bool

I added cc:stable to the first two patches as the thing-being-reverted
was cc:stable.



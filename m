Return-Path: <linux-kselftest+bounces-11215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2828FBB51
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5168A1F27174
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009414A4F4;
	Tue,  4 Jun 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2n61Qcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005F14A0BD
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524650; cv=none; b=Ladc0GeAvlS16zaDjNy+f88DDwnF7fAe+zI9w6pzp1/m9+dBICw3GbxOUtMrJ/NFp1IU8Ove7MAtomK7d563B9JIFPqaemt8Rvgl4PFdHKgwn+Wq3zoPybdcfxy7/2X9o/0Mg4OAi1NhxqZTLgqCLD4BB1DDX4q7uzma2s7y2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524650; c=relaxed/simple;
	bh=2J2obyLXuZLm84OoVhVs+u+eDYt1l0tpsTiknUdmAOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFkGZSe7n2XJ6xJ/okx/QGsUy1A3Ep5juSYgXkKnsYqhSXtY9AIoXe8WYFARRzuhJSUtf/q6XWrnfpCeDfSonsBcm+O/1YOo+XOSwlO4G6/5u59JLckTTlj7EHFChysLxZQ717ElJftNqS2kXRYXAML7jImavwbsASBBrBSe9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2n61Qcg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717524647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/91xk/bJbfVq3tbd0vXxIGIhiCMBEED20dA29kFKyVw=;
	b=T2n61QcgqzYsp9mpG/XY/7JghTdHFWVVsTIbNo9XX62/FxVQOsGpC2mMF0dqVmdtavcHVG
	YUX5meDvBF6n6J+jrdhDy91OgEym7LKMLUfAkHE+9AnQ0AcKw0VeJdxHES2nHtRwTJjeb3
	DUs/Gs+7k9xtZ2My3bjtIAC1ndrb7tc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-UkLDSWeDNxC6OgfwtjWxcA-1; Tue,
 04 Jun 2024 14:10:42 -0400
X-MC-Unique: UkLDSWeDNxC6OgfwtjWxcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E452A29ABA03;
	Tue,  4 Jun 2024 18:10:41 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 791C120230B8;
	Tue,  4 Jun 2024 18:10:41 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:10:40 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
Message-ID: <Zl9YoIAy+1bEnHCB@redhat.com>
References: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Mon, Jun 03, 2024 at 02:26:19PM -0300, Marcos Paulo de Souza wrote:
> Adapt the current test-livepatch.sh script to account the number of
> applied livepatches and ensure that an atomic replace livepatch disables
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes since v2:
> * Used variables to stop the name of other livepatches applied to test
>   the atomic replace. (Joe)
> 
> Changes since v1:
> * Added checks in the existing test-livepatch.sh instead of creating a
>   new test file. (Joe)
> * Fixed issues reported by ShellCheck (Joe)
> ---
> Changes in v3:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v2: https://lore.kernel.org/r/20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com
> ---
>  .../testing/selftests/livepatch/test-livepatch.sh  | 138 +++++++++++++--------
>  1 file changed, 89 insertions(+), 49 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> index e3455a6b1158..ca770b8c62fc 100755
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
>  
> [ ... snip ... ]
>  
>  # - load a livepatch that modifies the output from /proc/cmdline and
>  #   verify correct behavior
> -# - load an atomic replace livepatch and verify that only the second is active
> -# - remove the first livepatch and verify that the atomic replace livepatch
> -#   is still active
> +# - load two addtional livepatches and check the number of livepatch modules

nit: s/addtional/additional as Miroslav spotted in v2

Otherwise LGTM,

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

--
Joe



Return-Path: <linux-kselftest+bounces-29747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34300A70288
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117FC842340
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9992561D7;
	Tue, 25 Mar 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/J7G9+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2A1A08DF
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909386; cv=none; b=JFeWbkYCzGEPB0Wv0mwATeNIedcczaBSXde59D76VG978A24rDVO/e9KGqLfgZBuOy02EMehGW+sNI4owQpeXm4VsGjcvOF5N6XHsvYjDelCMG+FiBq6x+eGy39quJ3+x5vI/Wm0ZdcQZGlPE+mdj3uhIvi26eKyKhF0G4Gr06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909386; c=relaxed/simple;
	bh=TOHFq6nszgjgqXAKFFee9XkUWNIwrevRzCQ3tYpRlQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3o2hwsY5YMdlayhZUx7K4hTrLowhEwqPjCFlL/4N/cX1LJr7EwGoJsWxYu9PrX5D3rKILWbaruzg3ZofC0vMLKYGAVev/tdh53YCURKKarRqq4YEhClmPR3JhP/zwiE6zTA2+mBTXZJwR4EFDW3AXZepKWXfmgRbLtDg4t4BfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/J7G9+e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742909383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yXZH92AxwNSXO0lIlMyMaSgqAJeUyhq9X6U1qTQXDo=;
	b=P/J7G9+ekO/bUOmFs5JEVxkgSj9WWpxEoqXqWLVMzv0l3BmPAsjx9Y5HE0ziL3za7e0c6W
	jPk+bwwdRCQdzgZHaCk78TMewE2Xn3EKotqyUhv3gDrcLoyDtM45DefswNEk6cf1qP1E5D
	cfgmsXTGWU1S6bqAAWf8Llfss1FRvNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-cTqhb3OZMJegVeMbgr8dDg-1; Tue,
 25 Mar 2025 09:29:37 -0400
X-MC-Unique: cTqhb3OZMJegVeMbgr8dDg-1
X-Mimecast-MFC-AGG-ID: cTqhb3OZMJegVeMbgr8dDg_1742909376
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09C3D180AF5E;
	Tue, 25 Mar 2025 13:29:36 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.75])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 078171801751;
	Tue, 25 Mar 2025 13:29:33 +0000 (UTC)
Date: Tue, 25 Mar 2025 09:29:31 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z+Kvu14BseUfbYK/@redhat.com>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 24, 2025 at 07:50:17PM -0300, Filipe Xavier wrote:
> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Suggested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> ---
> Changes in v3:
> - functions.sh: fixed sed to remove warning from shellcheck and add grep -Fw params.

Oh, now I see what shellcheck was complaining about.  I missed that
there was no '\' line continuation char at the end of the sed line.  I
thought it was complaining about starting the subsequent lines with the
'|' and '>' redirection chars.  Good eye on catching that :)

> - test-ftrace.sh: change constant to use common SYSFS_KLP_DIR.
> - Link to v2: https://lore.kernel.org/r/20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com
> 

For both patches:
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

Thanks,
-- Joe



Return-Path: <linux-kselftest+bounces-43367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F99BE6F77
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 09:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02EBC507F9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3E239573;
	Fri, 17 Oct 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiOOBnBX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGUv8eBl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA448239562;
	Fri, 17 Oct 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686730; cv=none; b=V2xnka8gZPpa/l2K6OdddFycvlFJjNBBMDFAoiMMUJUJrf1ojs0jbeTKh9F6obJ+BncajsK0iZwIQhQvhIRha7OC29o0vBVHFqUonaWTq8fXBXGvpWmM368Fhdf/NWtXmQC6MSK2rf+oiefMqR7o+9eP3/VXZo2JmijflP6BMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686730; c=relaxed/simple;
	bh=7uApfUshzskwvlb+lkL0coLhqpb4NibRCoeVxoc/MOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcXVgZvMC+uqXshe3QXhlgXt6vUfDQy8YiADjC6N1QrHU+QT06nSqOw/ucdpBKPbf4RzPgP57t0texMctGgCx8gH+uHN5TYG1WsRI+WBctEM0APL3dg0H0K/iX3CSOYHIrOc+nwufa6qctWesspxbHtoS6g5jVybLJK9FariCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiOOBnBX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yGUv8eBl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760686724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7uApfUshzskwvlb+lkL0coLhqpb4NibRCoeVxoc/MOg=;
	b=fiOOBnBXs8PDT++LMGxA/woCmQbkeYyNBVQgVTUGCAao7gXFCaoPpS3veDp3I0xyGeJ2Ta
	R76as4FzEvuDY94RUqyc3kifMVKNyj/Wqrmf6RlRqN3iz9twKAgzAf4ZoC5rXPmFu/hzzT
	BnwRP155MOcPCS373sVj744YiC36ykapyI9QY7Kstf//gLg+LrAbbl6TQ5g9YA2cezwmyV
	Mg/vOQA+F35QR/97wSfWu9KKg1cqUhp1Fxu05wGoMFQx7DPe/RknAXVHh6eOD+hZxMYWbq
	jtaNKx3vczLipp+if9GvXf0jC38tYCgwyTmB3Ov6OOrtRPeKgi5Z6hCdm9UdYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760686724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7uApfUshzskwvlb+lkL0coLhqpb4NibRCoeVxoc/MOg=;
	b=yGUv8eBlF8vAooqwSUnOZ1l5KqSR6vO/JoTewYHSvtIHzHJEz43PlAku30nryzkIEJ0pSy
	IsmgsGmaPO8p1kCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, Waylon Cude
 <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
In-Reply-To: <20250926094613.34030-1-gmonaco@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
Date: Fri, 17 Oct 2025 09:38:44 +0200
Message-ID: <87o6q6vuyj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add a series of tests to validate the RV tracefs API and basic
> functionality.

Thanks for the writing this test. My bash knowledge is not great, and
I'm not familiar with the existing ftrace test, so I am not able to
review all the details. But looks good as far as I can tell:

Acked-by: Nam Cao <namcao@linutronix.de>


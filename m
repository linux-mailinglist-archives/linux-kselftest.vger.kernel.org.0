Return-Path: <linux-kselftest+bounces-44517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F276C2517F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 13:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58BB4F4D69
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62D34A3CA;
	Fri, 31 Oct 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBDtxLpI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUgDTxU+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A15329E6F;
	Fri, 31 Oct 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914931; cv=none; b=eG+hV8sE1ZKEU7D5hJMk8ckHrKLeJD6oPvVy9yWHWePDyVy6R978Wteq2SRju3GIYKQtbbXu/PHNpfxnWOFqtxKMQac06jJ1I9pDoekL090O06vDIdS+D7pFYuF5O6cz/hf+1INMm/1IB/lforC40XnGZ9zjUVj7VujBo372myY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914931; c=relaxed/simple;
	bh=pKYZnWJ2YoSZfWWV3TxBqXZ1CeAIdf1F+JJKdcAlTOQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZnhQmQCvCUcILwGq6CKU1a5h1morx/XNbxZ+MkWcnzF2rv2LvWDaiKuQqsIFj2JKMOLOgNDN3dfNE86595z1aAqoOZs0qIkFR7kGprSEZksq1mlBK3wCr/b+d6se426CVY0T3jPrJfJvMd7ZJSKhRF1q1siS2HsU+Y8Z9H5/EE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBDtxLpI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUgDTxU+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 13:48:45 +0100 (GMT+01:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761914928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKYZnWJ2YoSZfWWV3TxBqXZ1CeAIdf1F+JJKdcAlTOQ=;
	b=qBDtxLpIKsgaFJrJb5yQkoiQnDOKdKPtWgVIdUbWjGamvmK0enQSsnQPnnmrr2AqG2znUb
	JQRYciJP2qQk7OtqyH6E3tj8qizq081/n1S3HzBoVeK4U3dUBahfWUPwmq5MKltawOsQ5y
	qxVtVadysPztqZ6gWk2qBOHTQ+UvdYXV8sVLpm25tWJtGklXGvroCmuMEXMjUzyNQgU8hX
	jRW5Gvh1ZZNACty3QBtzaNoLEwclXi1zi9ELV34Z8gipZ5yyMm9w8yaV9k1MJOQ8S4FdSc
	wz43NyGVtqIla1+xlclfo7UP8mk3+N0mbt0wsIi864/Rp2I6S58/ZItZDgF1+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761914928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKYZnWJ2YoSZfWWV3TxBqXZ1CeAIdf1F+JJKdcAlTOQ=;
	b=KUgDTxU+KuF9DLrCj8kBmXI4kAF1uwZoqREyPnH8yTTl/j0zqpM+K0MLFXTqPzH7S8mhmX
	7LRP4gX6x08P36AQ==
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <80dec5ff-a9b2-4622-9dc9-ac65ca06e187@linutronix.de>
In-Reply-To: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com>
References: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com>
Subject: Re: [PATCH v3] selftests/run_kselftest.sh: exit with error if tests
 fail
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <80dec5ff-a9b2-4622-9dc9-ac65ca06e187@linutronix.de>

Hi Brendan,

Oct 14, 2025 16:45:32 Brendan Jackman <jackmanb@google.com>:

(...)

> In case any user depends on the current behaviour, such as running this
> from a script with `set -e` and parsing the result for failures
> afterwards, add a flag they can set to get the old behaviour, namely
> --no-error-on-fail.

IMO this new flag is also unnecessary.
The user can just do "|| true" when needed.

(...)


Thomas


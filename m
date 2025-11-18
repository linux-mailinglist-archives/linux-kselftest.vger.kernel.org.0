Return-Path: <linux-kselftest+bounces-45905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDAC6B253
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D378E362CBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9CA3587AB;
	Tue, 18 Nov 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwjDFgF3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLwdneCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8843074B3
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489611; cv=none; b=HOqx8xhmVOqA/nlYetSc4LcQXLHIv0HHVaTXM2eHEMBOVkzQvfYzuJAC0XYfYo7Sep4a71MGFG3FT0dA6pB4Pq2X++VOFoqX6lQ1tDSjixggMkSVRFUZPWkrWXRxhvHSkpm9uwr1gGB5T2T7mQLK0llqcjEvjI7yQJFKZczlN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489611; c=relaxed/simple;
	bh=ESkljyOopVtU50//2SKEaLXXjPSw66upROeHtwZHBTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB2/3/F9JpH7tmFflPea+noTP5ldXngQSLoJcqNosk3dQOMadxvwNA1QPIEMZzeF28F2LyWoNxGRgBQ9QBLB7wEi1SnufDYsr3c5PlxQAVtbGN8Es8LqR3bxELKZwXForSL87tkDKWOXGJw+BZLVpLIqAgpGecV1klp8qDNUkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwjDFgF3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLwdneCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
	b=EwjDFgF34aSfDxhdfDibjlY62PiTRmKjDzZh6KAWPPQwM7jwTubve97rOT4mVh8rh2wz6/
	o4VEtydbmnJXjjBJaw2uPORTFo3c7Z8jpIhInNjdUNO4lO+kvTI9hQ8nMJCH1PsKRuYklD
	qE27kgRN4i3bwLz0t5HnuXYXxdlf85U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-XIIgUbT9OJuR1V1523vSmw-1; Tue, 18 Nov 2025 13:13:12 -0500
X-MC-Unique: XIIgUbT9OJuR1V1523vSmw-1
X-Mimecast-MFC-AGG-ID: XIIgUbT9OJuR1V1523vSmw_1763489591
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a11d9f89so5828385e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489591; x=1764094391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
        b=aLwdneCfEURxR7QwR+JA//XqUSuJiIbzyi+clLnD3IqgHujVMNwN2T2nrf/ukOJ409
         1j6NmZnROQ9GXRlYiQ2+VolkampsITJDQKVJEsL9ECMWBZyCttOK065SKm5fVHo9AKUZ
         XZfvocAUJVJNmqSWOp0wLY5SyFJnCYJ5b5A3x8A6GdwvSnHwAgWaLBtcRmeoLgCHDsV+
         Pg1Fr0EoSEu1mXF1GRiXY3E2YCnZxBbA3f/9NAfB4aOuBiP1QPS7xqy3GfA1rnR0oivM
         IeiRb2qiCj7z8/rnETcuBpwJYVzlkvPL4EV+Q3ABp1oc7Zv/pOz2+fA76NVhZ+0d+fao
         XUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489591; x=1764094391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
        b=X25xqywRoeLnZ5d2abiWI67LiiB1gR9GLtpmXxryTjISjA072b40ted/j0PsGhtL70
         C56CN2Po2sM6682vgsC1XCKqxJGnUFQmN7nXBr16McVeyRTmt5rOJ9XzOEYXdTU7dvq+
         uz+IBF7rluLFZwkL/0OEo4vHmZ5FSfw3GBpByWY3EXJrk1aKR1PYQcsWMRlKHnhr0/CA
         YGrT9xIOVU9MUQdc6q2vA+BO7o46qEEGMsQbSW0x8ukkqXlX4V4Ht+TzZdO2lF84NgQc
         lL3RjcGxORoSD5oqb9FzPSIedQtZlCZ2dG5GYLwLnuTrjhyArRPs1fDhfUz9McpSe5Y8
         TciA==
X-Forwarded-Encrypted: i=1; AJvYcCX4OcdfNT2fv+HazuVrB2/+Kn9RON7vQzv5yghb0D/GFBi7+Co8Ym2fQC6iOWqgpKbEi0pmIx/09oO7mqQJGPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysLg6z32H9yfxAN3+v8rG2HychWJu40N+pQniyN3Y65N5ttaa
	yPUS2KQx1gsy+bGLCKqmlKBAJNND8acKZNW9iTL9xOqViqJPcaZ4PWdkcG0YhTpHguBl1sJhBL6
	sIX5jbpOVOo7dicSaB0EE06JEOftoM/dZD4GZKkSthDqb00QqrcXnaBcnMqNmtnrzmybzdQ==
X-Gm-Gg: ASbGncuRyR+edDks2WeEUHWODahXhEEvsuYGCohwFg58ANwFaG1S9TyKLVX7cqUVT/i
	UoF7X9W//fdQ3mtW6R+kms/eh8W3Jt/mR0xZSu+kmYnSo4BFt4et8rEDBKLXH7bSe7NDfafjXLz
	vaCJC6L1gjdmVEcRjXKg3vbrFTuzmpavURxeSU8OJZGFhQCE5BpgwEDIsJzI8fSMVs+3i+CRqZE
	rHXmNtGRUcAjBm5k/OwrQiloHUKfGbd0Y9WfAewbN4kEPmTk5UoIhae+hg1iIywrQj3t2vG2U5T
	PNhxMdAJsJpQG1YnnnhwvsFVaBkEkD66I1oNlK3B0Bo3uEVWI949wSRpS56U7Kdl/YyLI69TOPG
	gz1W4U47E2mq5PyknyLiwtQsNWS364MNw74nriwZATRQFm76je1oLMXb2f34=
X-Received: by 2002:a05:600c:4752:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4778feaa7cdmr147586095e9.21.1763489590816;
        Tue, 18 Nov 2025 10:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIT8ng0CUWbvzfqjNxNNDfLjFNDwG4+rLmN0Xj3SFNTvDx9hI+oXmEXYHOMQFCNSDvZBqLmQ==
X-Received: by 2002:a05:600c:4752:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4778feaa7cdmr147585685e9.21.1763489590295;
        Tue, 18 Nov 2025 10:13:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm21423225e9.16.2025.11.18.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:13:09 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 06/11] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <643ayuucvcaet3v47uwh22mahncfbm3arjqf7szs4apa7gsklq@clggma36o37s>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:29PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The init_namespaces() function initializes global0, local0, etc...  with
>their respective vsock NS mode. This function is separate so that tests
>that depend on this initialization can use it, while other tests that
>want to test the initialization interface itself can start with a clean
>slate by omitting this call.
>
>Remove namespaces upon exiting the program in cleanup().  This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test. In that case, this patch prevents the
>subsequent test run from finding stale namespaces with
>already-write-once-locked vsock ns modes.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index c7b270dd77a9..f78cc574c274 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
> )
>
> readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>
>@@ -103,6 +104,45 @@ check_result() {
> 	fi
> }
>
>+add_namespaces() {
>+	# add namespaces local0, local1, global0, and global1
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+}
>+
>+init_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ns_set_mode "${mode}0" "${mode}"
>+		ns_set_mode "${mode}1" "${mode}"
>+
>+		log_host "set ns ${mode}0 to mode ${mode}"
>+		log_host "set ns ${mode}1 to mode ${mode}"
>+
>+		# we need lo for qemu port forwarding
>+		ip netns exec "${mode}0" ip link set dev lo up
>+		ip netns exec "${mode}1" ip link set dev lo up
>+	done
>+}
>+
>+del_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns del "${mode}0" &>/dev/null
>+		ip netns del "${mode}1" &>/dev/null
>+		log_host "removed ns ${mode}0"
>+		log_host "removed ns ${mode}1"
>+	done
>+}
>+
>+ns_set_mode() {
>+	local ns=$1
>+	local mode=$2
>+
>+	echo "${mode}" | ip netns exec "${ns}" \
>+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -110,6 +150,7 @@ vm_ssh() {
>
> cleanup() {
> 	terminate_pidfiles "${!PIDFILES[@]}"
>+	del_namespaces
> }
>
> check_args() {
>
>-- 
>2.47.3
>



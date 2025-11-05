Return-Path: <linux-kselftest+bounces-44813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5216C362D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B986209DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF022F75E;
	Wed,  5 Nov 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBAAXVfd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFXgyRZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DE21CC49
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353918; cv=none; b=UZkW/Gy7dPzmjQESCrnRi+FUuVEj5wUZnBn1IQBchphVK/Zo9PgVk7C/pJfPi5n8iWZO+V6mhOsB/KXSsMj6PGdOIMM2P322uDxj9ufgGxneCY+We1Lr1UlXJ3aLHuGeQu27mwunKaS1a9GmbnKEM4y1qXNzYwuZLTsWhXIEb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353918; c=relaxed/simple;
	bh=P/3UCIyRDs5TY+J7sM5xjumdLDz5BUHqvdnv6ttKM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss6yxIwU1i2osVtN0thttNiWmxGKvSVQgiaErA8MPG066iwIQ/hYCRpWgBaBsNxo/3bd4I0NN2wr91v4RTn518tMcdU4KTTGASoXSwqVs1+BPpVipCo7Zd38eD9g+oQdNcjUIzUVjggKnhRV3ro1pP+yGe3HRWS+KyejRDVPnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBAAXVfd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFXgyRZN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762353915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
	b=dBAAXVfdqucE9FZBjgOrqFAJ56IB233nPnlW0Kp8eKXbElRtwlerhZtU4ES/qTSzVsDFRw
	UO7wtg5mAbf1VdR3ZG5fwjw2HOi8twWYBoN1HXJkmdK3u0Qp7F/jjFjmOlhNCATu2VlAva
	ILL1U+aVqenSV4V1qibHDZ/Kv9TI69o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-3BCiFiqqM_27Stel5_609w-1; Wed, 05 Nov 2025 09:45:14 -0500
X-MC-Unique: 3BCiFiqqM_27Stel5_609w-1
X-Mimecast-MFC-AGG-ID: 3BCiFiqqM_27Stel5_609w_1762353913
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5da68e5so1122413f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762353913; x=1762958713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
        b=hFXgyRZNzBesEhpnkl4cIiAr9E+WjDzTpuwqkQMqT3SasMtqhV9WVpqfyn5nuO4iNW
         gac3sldQWp+7X3c8Au+8FEi8zsWh4gdFf2TL5dAfSFWiU7r9FfKjFaseqw9cFcMl3hvR
         xU+ZsBGnatI9aK2YgMRCcT1MMZX4EawIvJZMc7d9V9zX1GJDQz7SvrE9AITFzWGSPlIg
         ZN9qHprWuCQKO5H1rSzTaOAgkLhY36kD2Y3LyY0F9sQQ9xASUpoSpoRpVCk/t7FTx2u2
         q527r1g8TNjhH4cJGIe30W+QvPlcCEqAABL6fW/8VeOdtuckYcg9AKzpON6xwPo3QcUR
         47PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353913; x=1762958713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOr/G235OdnGiS3F/X+GMIZ4jLjPZ308LjzapW+sWDY=;
        b=ssVXSlXmqz/lxToJkLOO6wCGKTVKJJvKK6dT6ZX+0AcHcAdzlORluCTxFA2xARz+aS
         sXiugFC0Mvfm0FzYn7CD1txgbe8gcypSh1jkgHFbtP7PScb7bnP8EchqzEGFnf1RzcAh
         baKpeLyvgpQ5OB7JWtZOrNNuvhVjJzRcQ48FEc1AmiSfQ+yrhPCAZL3y4dYFEE2eAV6J
         V/0v8Rax29SDbQ+7Oe5fK8ttcKmC72Htiva4EOhO421C70K7McX+GqLstMxwbLxSca2P
         vyN6pLt2/9AgRlZ4DRaX6x06qukA9O9Qh0QwVGRRMeOMttuI5U3vTkA9+jVWIT88WB60
         d9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWc6J29e2Qw+v/wzxAQRk4uhGJloax9rIEPD+mFp9uQfkraOlkVVO7HuGm2MV8JNqhTLeY5QxW0vth7/FjMN94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqD/r3WIqIj+rmpHTgBUyIIylXwx5IKpK6Z9NgRy1subgqWfnZ
	9haY8CGvuO85Lkp1+vhEIGAF/ubO4RGBhCCUiBc9ViJoPpvUPqO92tCQK30pHFOqSBBsIpK8fsi
	a1A7vbeyrOuoIQU/v6JjSkrIUyOeiJ9qcFvw0lj/KZYpQqwS9U6bc56sblvuPSlPQPlSk4A==
X-Gm-Gg: ASbGncsSVFa2Ow14rUHqUgTFCXLshJj5yDF4ak1QMjSyunH8Ukicln9F4PQcNbNYjon
	yf5HfSjMO1Q5uqwKHgf8MJUlRZwFDYaOJpY+cOqfD4LNxxQ3RT4AvugtraXrOSTJcr+pv5enbHd
	oXXEX0fvIcYkhXhY/7Pkh9I53jYtq/ahwOso/SFj9yjVtMPnALQWNZW6z4yXx+NYs1bNvw3hhLf
	YTG/ooOrHlJboJuBhEm/eLeA3/2toTkGonuDQ2nyok/rMlFI7HEOPDGVjClMfjU3D/oxM5riajw
	BUPiRRgj1a5pa4oID4Rm2YSYxl1PtXx8mPxCrK1ege+K6JqlWqbIMfAGzq4tzHWsSfPnfdaCIoU
	=
X-Received: by 2002:a05:6000:2883:b0:429:d3b8:7375 with SMTP id ffacd0b85a97d-429dbcc5d94mr6660625f8f.2.1762353912863;
        Wed, 05 Nov 2025 06:45:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5LAfcIKI+UGb+/zhR4tf/kpuE1QbENGNGMuBGWjUYd5tgElIuXzgUwRSVpo80Ale29EF9cg==
X-Received: by 2002:a05:6000:2883:b0:429:d3b8:7375 with SMTP id ffacd0b85a97d-429dbcc5d94mr6660597f8f.2.1762353912389;
        Wed, 05 Nov 2025 06:45:12 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbd1csm10956989f8f.38.2025.11.05.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:45:09 -0800 (PST)
Date: Wed, 5 Nov 2025 15:45:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Message-ID: <ohe42glr4yn26ql5fdvrwrhawfqo2vy72i4zofjqwyqba7wwdj@5usmy5fczxhe>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:38:58PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>In preparation for future patches that introduce tests that cannot
>re-use the same VM, add functions to identify those that *can* re-use a
>VM.
>
>By continuing to re-use the same VM for these tests we can save time by
>avoiding the delay of booting a VM for every test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
> 1 file changed, 50 insertions(+), 13 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 4ce93cef32e9..678c19e089a2 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
> 	"Run vsock_test using the loopback transport in the VM."
> )
>
>+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+
> VERBOSE=0
>
> usage() {
>@@ -443,7 +445,44 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>-run_test() {
>+shared_vm_test() {
>+	local tname
>+
>+	tname="${1}"
>+
>+	for testname in "${USE_SHARED_VM[@]}"; do
>+		if [[ "${tname}" == "${testname}" ]]; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+shared_vm_tests_requested() {
>+	for arg in "$@"; do
>+		if shared_vm_test "${arg}"; then
>+			return 0
>+		fi
>+	done
>+
>+	return 1
>+}
>+
>+run_shared_vm_tests() {
>+	local arg
>+
>+	for arg in "$@"; do
>+		if ! shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		run_shared_vm_test "${arg}"
>+		check_result $?
>+	done
>+}
>+
>+run_shared_vm_test() {
> 	local host_oops_cnt_before
> 	local host_warn_cnt_before
> 	local vm_oops_cnt_before
>@@ -517,23 +556,21 @@ handle_build
>
> echo "1..${#ARGS[@]}"
>
>-log_host "Booting up VM"
>-pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"

Why here we used `mktemp -u` ...

>-vm_start "${pidfile}"
>-vm_wait_for_ssh
>-log_host "VM booted up"
>-
> cnt_pass=0
> cnt_fail=0
> cnt_skip=0
> cnt_total=0
>-for arg in "${ARGS[@]}"; do
>-	run_test "${arg}"
>-	rc=$?
>-	check_result ${rc}
>-done
>
>-terminate_pidfiles "${pidfile}"
>+if shared_vm_tests_requested "${ARGS[@]}"; then
>+	log_host "Booting up VM"
>+	pidfile=$(mktemp $PIDFILE_TEMPLATE)

... and here we are removing `-u` ?

If we don't need the dry-run, I'd suggest to remove it also from the
patch that introduced it in this series.

Also, maybe we need to quote $PIDFILE_TEMPLATE


Stefano

>+	vm_start "${pidfile}"
>+	vm_wait_for_ssh
>+	log_host "VM booted up"
>+
>+	run_shared_vm_tests "${ARGS[@]}"
>+	terminate_pidfiles "${pidfile}"
>+fi
>
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>-- 
>2.47.3
>



Return-Path: <linux-kselftest+bounces-28430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED339A557E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7DD3A765B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 20:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB141FECD1;
	Thu,  6 Mar 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwyHpwtl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821E1DDC18;
	Thu,  6 Mar 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294563; cv=none; b=HIQpHHI6pMS3GyNpsrzpKsytKyY6Pa1sl+vFMzFRbicaA3UVS1kQql9/tBn35IobWP76kWTKKneeJHxt/CIIgK8206jFIFk6Q8MoS3a0GCXGYVhSWfd5mVJa2ss1BI/nV/HxqfFAncBnqhMwJconG5ywPtFrSHHvdCBJEzuXRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294563; c=relaxed/simple;
	bh=1yU9J4BkgrNKaADFbQBRXJ7/o2OWJiL9AwOPGuiFPX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8E4n0gJwRC253P4oI6RsqZoqB+KhdI3iT9YdU0b9Y7AzUcfSmzutzdHzvXECl/18AQtaD/jfDhA/v9aMWU06Q3pknX7Z3ZQ0I2EkdddYxvvwCqhhQ57TjNRYi6BhnWV89lQ1hhlqt/U58ljI0MSYxRdGkf+R5WOZ1sG+td42Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwyHpwtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B1FC4CEE0;
	Thu,  6 Mar 2025 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294562;
	bh=1yU9J4BkgrNKaADFbQBRXJ7/o2OWJiL9AwOPGuiFPX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwyHpwtlXY/fyX2TFYLwuDzT+hd8zMK9x2tftLW/DlqJC/h51AZ6bhVUeTihqBO0V
	 IOLD7nSiubRhMLXXyYT5fTpzMZI2kw5XS2Z4i+MDyAph3xxmpRjXRNTcZAePAMgjRB
	 /YGXTGdQN0HkPUoW8LaVta+KsPHVKp/lJfD1UAu15H4kwgPCjy9Dq0fcTjD5cZbr7c
	 ZlmlhKRzBytQB7TUmWuD3UFp3XST8KtnVrT1pO41nc5v2QbSclO2Kr8kecWfTODyKF
	 tOYd0KTdAjq661rrScqtW1HeaAFNqPzBXHrxwbdno6QpivG8mdp61k9vR0xyiADQhT
	 izGFTKj5J1DBA==
Date: Thu, 6 Mar 2025 12:56:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, petrm@nvidia.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] selftests: net: use the dummy bpf from
 net/lib
Message-ID: <20250306125601.522b285a@kernel.org>
In-Reply-To: <67c9f8ed24f9c_1580029416@willemb.c.googlers.com.notmuch>
References: <20250306171158.1836674-1-kuba@kernel.org>
	<20250306171158.1836674-2-kuba@kernel.org>
	<67c9f8ed24f9c_1580029416@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Mar 2025 14:35:09 -0500 Willem de Bruijn wrote:
> How does tools/testing/selftests/net/lib get compiled? 
> The other subdirs of net are separate explicit targets in
> tools/testing/selftests/Makefile

There is some magic / hack at top level:

# Networking tests want the net/lib target, include it automatically  
ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)    
ifeq ($(filter net/lib,$(TARGETS)),)    
        INSTALL_DEP_TARGETS := net/lib  
endif  
endif  

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/Makefile#n129

> And what is the magic that avoids the need for adding bpf objects to
> .gitignore?

All BPF files are suffixed with .bpf.c and we turn that into .bpf.o
So they have an .o at the end, I think the global gitignore ignores
those?


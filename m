Return-Path: <linux-kselftest+bounces-35738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B60AE7E81
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED591885776
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805F29B768;
	Wed, 25 Jun 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faZTRF5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB792877DC;
	Wed, 25 Jun 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845972; cv=none; b=jcyaYvKBPUL35ssZN4SY8Q9TeppGWONiNxRPgz/gNCs+47sNQQvcEaCVI/bgJMEwqHXsABzo1UNYBiYUB+5Zv8nCiAJntsVqRJjegxPLC5fQDPIztYv1nJjSxjJBbJDA7Sn75Mvn0ANM1yKlA8SUkyIeFKAB6BDpSoHeNNHLzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845972; c=relaxed/simple;
	bh=eq0ugjWPQc77eo7Cjd6JDK9zE9c6VJ8xPpHJvKH+2z4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rskJEbR9X8z3jVg4kfyqmql7PUHDi37RfXG/0owiQdCg21Y+RGzSntk9gGof8GiONilsVmklfJ14cGw7wfYQoI+4nEiYV9agjvNM/Yz7QlwzoLAAzvC7DYcUgqjdElFml8cDFjwAlIlqgNJsayBAPsruUrwenL3cPnVPV53d1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faZTRF5g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3119724f8f.0;
        Wed, 25 Jun 2025 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845968; x=1751450768; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eq0ugjWPQc77eo7Cjd6JDK9zE9c6VJ8xPpHJvKH+2z4=;
        b=faZTRF5g/3ifRokZI99ne9COt2clKYPMkdgZ+XyAHy/shkOFywkxXejF1gPjYaVzCd
         P1L7Q4Hz8XUkZiDKA/D58rqp29c4i/DScBUu8w+5hciRtD6F9ZVq7uhB2b8ttqZKzSAY
         3MtgBX5FN0EAM7IOcuXpfxWbaH1q25QhsUzuFv09Xr1AnWJJhlgmo0xDDbjr8aHtdHjx
         LkqbL//qmvN1KF9/NGWyLLMbJARl7nuiE/i/bAjV6HY6lfLS7Mx3Bm3cj+hDy/TidrAs
         E3EWi8M9X51Cwc8DgqO+IBxIgXov5dFfqAhEbrkJ82wu+rOyQKIx8h6URDaH+ERMnyzX
         qzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845968; x=1751450768;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq0ugjWPQc77eo7Cjd6JDK9zE9c6VJ8xPpHJvKH+2z4=;
        b=hB8crEFgAfyO7o/P1cKxZ7tPTwW34FjSQIWg26hkDMWhX0fAhDZw4Hhlvg3QOhHylF
         X9b8yV1vidKcP7ZrMNg2v0CHzgPXRzb3FMvWYPoqtYQggzI5bkQlB46nMQk9NwEq1ylx
         8pvwMj3a7SYgD7yPj2GB2b48ezgTU8EEh2p7vBQA6ecD9xtFD6KfrI71ej5tjAXSoafZ
         sZf6NksCwEaTXA4oQm6PIVIiT6QdNDOGnj+3bx87LqVYhjiNZhngvrV2CMlRoiQdywdU
         hpRfTGMsna3HkFMvoBrqXMXGYxIvVW9K12haqg+sk93w3IICDXbD68GSRmop0v2W2XN1
         ADkw==
X-Forwarded-Encrypted: i=1; AJvYcCUs0wKKGKgx39MTQy8lV4eOTCuGUaaXkp5dHZadLke1y/nr/SHU5ZOninmDBM1D+w/a1n2WJLAJi7p7t8+xg6U=@vger.kernel.org, AJvYcCXMZtmE8iCsMqwSCmVa4+fDzx8m7Ltb/RG/5v4mjJEq6QrXUdB6O4fcllOMP646tMYksm6lu1BE@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpYXufTS1k03V+V1/zJyvpnxNn9NbcP8IW8Ky5RT+eeZAtOoy
	7wMi+0b5xI7gvlCzpPR2B2GgyFV72ckpRWxbuclZiXmBEvFUkArdeCll7UeKPClk
X-Gm-Gg: ASbGncvSTp1UB62kccOn0wKXPXrpj03TsnUpfaJrqimFzbGwc80ES6Bm3BPU/779Pla
	I7pfHsrPAubPDE/+PegzMPFW+LNaZsLGWtFsIL5XywxG7D+W36ri96I7AagHb1pLrcj3J3AmQN6
	9ZSl3WBildVxw6l0ZzwB7it0UuOkyhKbG1TEA+B6Q3cC7iDFWCgWVv2qiwLud5kFfrU5PcHNxyJ
	I/HUuMXaQUIUOXSV2Orn52tGbpKeujaO8MarOoh7DqJkrrBLSnviPNXbO5RReFhfj6QNAMBZiTN
	V5ZvWPiPPxPRy5VFrQG1CJbJH0mnKbM5q8lnVwAQw+Ej9VR1ryuiQ3YV2vZ6xLmZSLS186AJRXM
	=
X-Google-Smtp-Source: AGHT+IEAgQc6ig7DVbs1YRD0iJmxRwmF/w4sNwjVbluQ4I30Nby1sIA9NFLX0B4HDLWix8ABPLmrPQ==
X-Received: by 2002:a5d:64ce:0:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3a6ed66a3a7mr1785677f8f.28.1750845967845;
        Wed, 25 Jun 2025 03:06:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b913esm14703125e9.33.2025.06.25.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  andrew@lunn.ch,  shuah@kernel.org,  kory.maincent@bootlin.com,
  sdf@fomichev.me,  gal@nvidia.com,  noren@nvidia.com,
  ahmed.zaki@intel.com,  wojciech.drewek@intel.com,  petrm@nvidia.com,
  danieller@nvidia.com,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 03/10] netlink: specs: ethtool: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-4-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:51:37 +0100
Message-ID: <m2frfocfo6.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen replaces special chars in names)
> but gives more uniform naming in Python.
>
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> Fixes: 46fb3ba95b93 ("ethtool: Add an interface for flashing transceiver modules' firmware")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


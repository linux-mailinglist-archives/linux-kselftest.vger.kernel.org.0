Return-Path: <linux-kselftest+bounces-25498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2DA24258
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A857A1C9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B31F03F5;
	Fri, 31 Jan 2025 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl9iSp+d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F41C174E;
	Fri, 31 Jan 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346624; cv=none; b=dIA0uYp/CwPNZIOb5KJ6KZwUkW0nVTisr5VANQ5YafZnprQR1KbX/QZFLTxdhqauqgamhtvBTydUhYy5rBsF8WlWkUGTygJIk+sQvTR8m9kFlNFoCty0N+VDcd0OQm5BMdoBPKzhgPbKBYZut17TuLTzjhy1/a2R4XfLeEq4/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346624; c=relaxed/simple;
	bh=6SHGPNnD+6Hd94JCDS4hKGOqSS6VX3tMan2zraCxxLc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uF/7tzNl7Jn1EUHx40Ghsld3Jr6TMjHyfFXULOtS5NAcchsEB/3F6ViMaVX46ILCjeC9XPS9X210JBhUzJAq5yaMfCYFV5VGWuDBcxj9lbdbxlFcceBPXfdoff9CaBwp9vRFOX9dtUb9WVArGTJx7uKnzHAmXnvy98K7TnA+tFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl9iSp+d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8edad9932so16542766d6.0;
        Fri, 31 Jan 2025 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738346621; x=1738951421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpMrr6tTcxUny5yGhg2pM7dvzKt66D5ST/0RRfO4vVk=;
        b=kl9iSp+dCF8PnCn8UBWsBBcjGRUv5Y6guxvQ6E6Qh5uZCPRMsTG9Ma023aHpqp5pig
         jR7rkMc5FgPg5wHquqOWNwRgFv/eBLzBqLfA9zFhN7ixnlvomb+wSanRUyvgl9DS0E3d
         PHkqMNQSvR+8e8WfJmcoLvXd5q9L1NvKQyz9PzUehPhl8G5h2HG2OcPtpmzOJiL+E785
         cW+jWF1FoUGSRr5rQOv6XF1B2tazCAphKvCeFo0uzZaI/xvI3TREIkic74bZeqPKiUKG
         +U2MiO+pjH5HCq/8e9N5TQQPvgvtD7aG96DrprpH0tKhcnmp7SqvMxV5d7tD69aQWEgo
         YU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738346621; x=1738951421;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tpMrr6tTcxUny5yGhg2pM7dvzKt66D5ST/0RRfO4vVk=;
        b=Ovy5CYaEqLgXajF0QucfR9MxtyReRf3vJj+1wEuB0gFYFe1H4rV8E/QNpCYTv1mGxc
         pZCtJ0r0osz3jDbWMloHAVJdSt3ZZBY3cp15VGy+wfJJRxz0XDh0sHRUFIbvEAuH24hZ
         uIuKQb+yQkryThdd/mwaarYhuWQDaBKNXWk8zq/oUD642ephaOyQdPu9UZSGxna4PqhX
         d5xK2L88EQNvU8Dv0qbgILQI1oX4Wjs+4oseG+xrNXKQHauprC77ddud9Cj0l6ol2KtU
         D6qB+WH6MX0YrkX14PMhZUKZGma7+zij2EuX9pWiwDBUWHMahkPM1mHsqrIT8IWIFVbo
         iYdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/w/n9o8dxy1QvoA7LEQ4ZqAOdPOXBqLhflbrvKZcxJSgUGKBtOuqDtvl4UvbhF09810qETjFr@vger.kernel.org, AJvYcCUJNyaywp1dR3cJCOwjb5tVp+kd3XfexFVCRopKDj3Gx6LBwkLIjikQuajjfNMeo9TQgk/92++MS6NFZziMEPzh@vger.kernel.org, AJvYcCXX83kA1hA1obBG0bRrf7iT+OJwAv4SHX14WJMRNlM3Lpg4R4phtrWj+6oX5BHeTVa/ft2Q4zkjfHJI9qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWyFDDk8Fux5aBXhNrR6Qim5/VhwZULMqkggRzK74Ue/33RC5
	6U/IyWotO3LP7yxdPewvxMZcHKPP/2JTNS3UqPFqeDyxCHOQdQUR
X-Gm-Gg: ASbGncurdBnXfCBMlOmtq8ACkQnZoN8nZYhFwx2pW48HhL5kqRQtbThyTTeGnT4zCXN
	FQ3p8CfTdfGW+9JppR3JN8zzQ62im3lWfnApFB4jb1wqqdUSox8997P1DhkSZGoKp2T2jSG/6Oq
	ykJdHXCsoYTcQSxS2nrmIEbWX16oiN2uK7ZRbgpWt/l6nHThTOCbdd1XGCAkPsvLAGGdQ8mtqy9
	zgyGkkdNMNPTB7z9cD1SmXf/g+vdoKbMH+OxhJ+RP7yV2vvC7DLGY0VWdbw8oXXYiHZ9og4zgj8
	BSAlscmWKIT8D7vUlVcIRWf6D+FKX/8sHl2VeTMz7sQUK+SbHs0Ebjx0IdeFacA=
X-Google-Smtp-Source: AGHT+IF2NPh4aSX34R9VXcpivvt/FXmGXLUSxgcDOoxuyD4bDxVnP01OCVr3tTRXEza8746zaDnHug==
X-Received: by 2002:a05:6214:2c05:b0:6d8:8d16:7cec with SMTP id 6a1803df08f44-6e243c8ff23mr217332476d6.37.1738346620730;
        Fri, 31 Jan 2025 10:03:40 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814029sm20454326d6.29.2025.01.31.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 10:03:39 -0800 (PST)
Date: Fri, 31 Jan 2025 13:03:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Josh Hunt <johunt@akamai.com>, 
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com
Message-ID: <679d107b78924_2741f92949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z5yKa7gz72+JEOXr@debian.debian>
References: <Z5yKa7gz72+JEOXr@debian.debian>
Subject: Re: [PATCH v3 net] udp: gso: do not drop small packets when PMTU
 reduces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yan Zhai wrote:
> Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
> for small packets. But the kernel currently dismisses GSO requests only
> after checking MTU/PMTU on gso_size. This means any packets, regardless
> of their payload sizes, could be dropped when PMTU becomes smaller than
> requested gso_size. We encountered this issue in production and it
> caused a reliability problem that new QUIC connection cannot be
> established before PMTU cache expired, while non GSO sockets still
> worked fine at the same time.
> 
> Ideally, do not check any GSO related constraints when payload size is
> smaller than requested gso_size, and return EMSGSIZE instead of EINVAL
> on MTU/PMTU check failure to be more specific on the error cause.
> 
> Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


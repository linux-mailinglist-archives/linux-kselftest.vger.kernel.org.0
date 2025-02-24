Return-Path: <linux-kselftest+bounces-27368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D28A4296C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EDB3B26BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157B2641E8;
	Mon, 24 Feb 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToM6MJuO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F026388F;
	Mon, 24 Feb 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417351; cv=none; b=EeFhMY0gEgBYO78u/7WkISuQCvcaP3aCtR4OHpjUbQQ/+euQ+KaT3JnM8a0JT0OikVhBdgoZDDEC5bNXiVOjELGjDG+yDZsTyZfaxIDtfdzWDkxsrb0B4Nprl70vV0QNpI+IUJab9zGz2Ore7kpOCoaNbM+niO/t8xIPZIYOql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417351; c=relaxed/simple;
	bh=fH4RtBkSRZW2kBeXi3P/AudbFsIVNSe8yu+5vaExYfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhV6IcHg1OrhgXhQ2142BPzYKDFhlpyWdq/zDdT/SzZmziOGGrlC4XZQmA2kx9d2fgFrOKWkWlXIOMFdd9Tl+VU5ZZd/JiQN0wZ3Sn6lYx9veZ5ylvfgytvR07waez+Wwy5vRV2XUw5LEmfuu/opFYzR/Tczuk3H9d81oGOuqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToM6MJuO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220ca204d04so75469655ad.0;
        Mon, 24 Feb 2025 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417349; x=1741022149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxLi0WJqLjDUsJq7l6SDZpuIuRBeCk6IdkUiuE+2Dwo=;
        b=ToM6MJuO7wZFueHyooNxLk0pntRFLvGtkX7d/Mfvpqhjqy0f2HccSqHAuQHgFmqJqD
         7YnWiE5PmlWaQZ5mKrabVUyrNB9zB3LhjpJsI5gYeAskmWShl6qhayyFiiW+h94YNIgR
         0zynrg9eSKT3eeTcIQdGDDRLN3Sj24zEzXoj/CIJ80F0xBVxMR8B/zr6ltAkgzVTdsHf
         dTpYAK7DyZRAvgM38XDE0XDK/w1CpnpnLbRZ3HSsTUOsF7vP66OMEf3LbXuYQhfM2odi
         yT7t/WmhEk1xajHAUFccU8SCnvuD2EK7TR05TUrVyUJKFk+iZ3cFH4/oeEMGOVea9yYk
         sf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417349; x=1741022149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxLi0WJqLjDUsJq7l6SDZpuIuRBeCk6IdkUiuE+2Dwo=;
        b=cpV4DmtZlVqjI1kXrC9RZrMPjaEO+SEHYZU+Y1V8Ao3GzyBJ9Yyhc6hmpQy1QQF9nS
         rNrE9y1PWfrpmN0oZe6bXCIbE6PBj1FHwwpomD8cBKncePZDqr9Y22pobBaqpRdNzenE
         /QPXnmQnUKTDxex7GwF/ZGD7EN5V3loxFBWlzKK2hAXxKBx6Gwtf6eP2uw09TmbjWMty
         6NeXZDhOHcDLyFDH4IC+ACv/oGwv9em/kxVHsJ6B1wTz3yJOzP5bslqYlB8tXHLJ9xPN
         C2Ntw/J1wzmxpjBkP26uO9Lg/Ij1K5in/W9S5zHQiX0cKrG6jFbBdQmbNxdGgd/OLRcL
         aWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Si/ScgG4Y87NQVFsZDheI4iQc0espPIbtI0FwS739PRtA9HtEVhQDdoSpBtAzvgb6NA=@vger.kernel.org, AJvYcCWgwHuVNRWIQPssK7YmtnS2OUTsJ8AVeayg/JD+778KLTjsJ7cdnSaF/qpKDGAyxYALC1uiBibLG5vQ@vger.kernel.org, AJvYcCWvKUT4HNtLKTbcJnQnKkwhAUpLV+BP2XfyMyibQ3PjJznpjiB5lHZPQZvZvNrPBrUUTR9v+4PgR87zXH78T3qx@vger.kernel.org, AJvYcCXaY5eeGgpllUn9o+PaDnrC24BESD5BEZE/c449WAqfHZUJHlatfBQTSS+Jn8LeLblwkEmkpyrCmXZ4NIB0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TxsfoY7nIOLE8Ltg1tVJnhUZp/kT271/9r4Dxur7riAQOYGs
	NY55z4iWyielLOW+KY4AAzPQbG2zfU7+QgfaCONS+t8Ifbh+yOY=
X-Gm-Gg: ASbGncvxl8Dw0e2+i0mSDJEn4cG+k5UI2m8IR3O+1J+Cu4RDRyh6sw6/LbPei6vL/WK
	Md4lvdVlv+U2qad5Uv/HgOvkeZB4yT5btQ/9hWypsluoubudl0FnULOZRsGsTmsqFzvH70Lt+ru
	x7XoCFE3UXtJe+1rrTDUrmULt+ZyxATOBhpw7bE5EWlRV4lvAEkTclUlE0dqbanUZzW8DXCofH2
	LOnD1DKBCie5vYpMXAaUMO304NAMeb9LPzm1SlORZ85M/LXXaoKBa/RetEsrPCsOv8wilVniym1
	tXAvdnfuNTHdBupC1+Jq4bl4Pg==
X-Google-Smtp-Source: AGHT+IHX3hMEBBORSG6Giv0hdr/rxJRv/ocP3i7v+0Nr0JPqfdQtTKmVEfvG1d9RA3UeZWNnTu/9iA==
X-Received: by 2002:a05:6a00:1947:b0:732:623e:2bdc with SMTP id d2e1a72fcca58-73426c84885mr22523269b3a.2.1740417349558;
        Mon, 24 Feb 2025 09:15:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7346d9b1af1sm1497263b3a.71.2025.02.24.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:15:49 -0800 (PST)
Date: Mon, 24 Feb 2025 09:15:48 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v5 6/9] net: enable driver support for netmem TX
Message-ID: <Z7ypRKrKN0SdBOM2@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222191517.743530-7-almasrymina@google.com>

On 02/22, Mina Almasry wrote:
> Drivers need to make sure not to pass netmem dma-addrs to the
> dma-mapping API in order to support netmem TX.
> 
> Add helpers and netmem_dma_*() helpers that enables special handling of
> netmem dma-addrs that drivers can use.
> 
> Document in netmem.rst what drivers need to do to support netmem TX.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


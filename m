Return-Path: <linux-kselftest+bounces-25229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A11A1D6C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB1918876A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFB1FF7D5;
	Mon, 27 Jan 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOjP+ZE/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067D1FF7BC;
	Mon, 27 Jan 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984476; cv=none; b=c4tTQz/FCC7IxRZEkfRJ6ZC/1nvbmCm0fMROJa+pXGREY273rqBN1eb6acZ6NSLWHUBFnkWsAgOEoMNPcZ7EhNyzauG5ZIzbyv84CqHphAYZ1IxLkp9947W/W39KNszK3XihS3VeJDqT/br1Qxb9N/RQfgsNsAwXkN4DHz4XT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984476; c=relaxed/simple;
	bh=NF/Z/6mnFJoQiKz+vwQTi2iRfm1FPQe4uNx+uFyDabs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbFqTJJR3DqQ8jD5vNSN+3E3X6Vq4u6OxmX++pOeXfcbokuIr+g/0bEttEYdcpliJFzmXEx0TXHNrUDp61sOc5aX/pA2WsQjG7zE2cbcM5BgoUfvsju9KiBHHkvVyPOsEQnUzPDUmAwJOGnYULYk3cDwV+OkU272jlioSLJ6NJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOjP+ZE/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166360285dso73191995ad.1;
        Mon, 27 Jan 2025 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737984474; x=1738589274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fzsM1Pf9RpP5XFZ4SrQcsGyrdjLhqybOi4MsyjGDF8=;
        b=OOjP+ZE/yKJEBWertxSUudYR16zufYgV4tw3q8Hth7uD5r6+C8eligo7gfweeSNFtA
         tKm+Fb5H/ctq/CwBrKvAtJxpbjGPmAFPzOJzuI8ag2CXHyIGQQlZI2yBXzqym6WoNK/d
         5VVN2pzfxp4MHzhmkqGYDe8DbkOr9QBAxjBmNkZbM/hQ2jV7lqRwIgg+x/cawaSbu05D
         k8lzgmFSqXL2QmLhZKKO8fZakWwAyENhWZ0xrQw/wZ0/5GxVZNt0TOsJRcWbukMDLGfS
         b+vaOz0FhLWENvvx7/9JvR8vYROiwdwzArgI74N1ND0GjbPh7y4e8NmouTN7i81ZgosB
         qMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737984474; x=1738589274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fzsM1Pf9RpP5XFZ4SrQcsGyrdjLhqybOi4MsyjGDF8=;
        b=eZijwfLjr6dww/t4jbR6hRhx1cKxwGbTAduPQv2k7N10oN2Hqoc5ZD5/GIUnvRX7qO
         KYFkwV4rRqndxnxXihJKyi4/FXeKNqORXqU2QXHl7MS7ZESA1IgFTHeqS4ZkwNE9mWIf
         W4enfbLgEf4RDjCoeO0UEWdBtFH/T1oWz00+5uAKQ3PEy7QNrB+0V9J/mz1qNOY0uW3W
         HtUugE4ykOnrrACavaUqkgRZZYQKd73uuNkF7Ax9z0OsRKAvJp4EJPER1WIRBduWNV0A
         ZkpWHJJi8/hMgUbfGmwUibTaDX/DU0j6yD8i18oZJTBBsN7MYyTRN2b5tgFKJnU0jFwv
         s7ow==
X-Forwarded-Encrypted: i=1; AJvYcCVEKtU6AOcHCUCKLILThOYyLsdHtaBkC714YP12JKTqvMoHyK01nix2GgmqKqXratkZ7yOHBMkFRaOSyULqJRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbHLYi8L8jrmzYtzzLMg+zn3I8i4qrhaVBXc2R7nYj2wMy19L
	CRXoHpWiFyxGY5XmiWaHjfSBY8UOurgUOCp4WXd9M53Go7HSmi/0l9wMenRVzdo=
X-Gm-Gg: ASbGncvN8T/UUD41VpNjqomnrrweRqXs2PFbmgcRl8DKT/3qnysULEGWCpRA58TPqIJ
	wCyc0YIEio608Goi/rYoSRltEpxDWUcX2YW9FljVIqVdtmmCLT8tt3/g419n1OW9fYiAH6mT8t+
	+LJ3CQFqQc+lt9+jjtkpdFlKv4Uv9LK5+F9rC6TNazwAgPt/v85I6VdZ3GHo7/Gj/kB03t1mLhF
	Jojw03cWdlP6GmajOM0A6VoWJCvdrFLIvHgs63DI7hWZvt36whfTxwSjehuxPf/pYyCHmwOn9jH
	WFFod6t5xA==
X-Google-Smtp-Source: AGHT+IG+7LWtEYr2z9HI7ddUozeou9RSMSgcY01U1wQ6rGuPVQtRGglbs+jigdjYpH9nyrrko99Isw==
X-Received: by 2002:a05:6a20:2591:b0:1e1:e2d9:3f31 with SMTP id adf61e73a8af0-1eb2148df72mr54770041637.16.1737984474129;
        Mon, 27 Jan 2025 05:27:54 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a76150csm7101435b3a.87.2025.01.27.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:27:53 -0800 (PST)
Date: Mon, 27 Jan 2025 13:27:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"liali@redhat.com" <liali@redhat.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Boris Pismenny <borisp@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net v3] bonding: Correctly support GSO ESP offload
Message-ID: <Z5eJ0ZaOxdN2ZOe6@fedora>
References: <20250127104147.759658-1-cratiu@nvidia.com>
 <47227635d220ffd8941b65d778e23a578707aa96.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47227635d220ffd8941b65d778e23a578707aa96.camel@nvidia.com>

On Mon, Jan 27, 2025 at 10:45:21AM +0000, Cosmin Ratiu wrote:
> Same as v2, but I added Hangbin to 'Signed-off-by'.
> 

Thanks for adding me to 'Signed-off-by'. Next time you can add the change
log in the patch directly. e.g.

Commit description
---
v3 changes
v2 changes
---

Codes ...


Thanks
Hangbin


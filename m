Return-Path: <linux-kselftest+bounces-32477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42424AAB8B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519DD7A4F9B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3328E597;
	Tue,  6 May 2025 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO65puX9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77781309143;
	Tue,  6 May 2025 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493836; cv=none; b=qDmnvkKHBERyLKmmBL6AYOtYhuHgaiQAB6Y3NmGYFB7vIFQf/rOnskkJzItXT1as5EuzrgKU6JiqBK1PBAt3CsAdM0n7h7Hxlvx4a6KkAQ1d+qL4yOWNJ9dLs3aSV7zGhnK40OwdeFZ+8Yi1XNuu7KBDhaRbrhf214WWRPCY83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493836; c=relaxed/simple;
	bh=s29A+0QfARiLil6OgR/Kvj8zmAUaQ7CsmyswuFuRxp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD1ahM84RTd5N6AJO8wKNmbb5KFQiXm5OLeYVtNbEqi6GbelHOzELjjYZ3V9ClJnql/DuLNWB9OidhlltjcTewIxpDd42AkQX81ulai2ZBRTwgZv8ixG8fGNRYLZsHRk3Mjci2kgS5sLLKXqzxZY0fHomHwm/8BYPQVmXvEs3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO65puX9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2260c91576aso45280115ad.3;
        Mon, 05 May 2025 18:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746493834; x=1747098634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIAVq6usprfb4K7O7IY6gkWciH8NFY8vqc9fzBoEj10=;
        b=WO65puX91kRDBzQ8nLN2PCMQ5a3SdqjcDFS+MkS1A6sAc9DmlbQ1ijfelPidGM2srj
         Awj22BeB4OTPmPvYZZQ2R/VYt7y06/Ek/hS177AThYb/3cWbTX25NaFK+GFElmsfcGB5
         89XF+/tOFi+ynyOZevbKgEMJD94914dg6nzpXTqogOALTffGzUe2/qA7C1jQYdcSs3JR
         vWDDI6O1v+hoptKO9T/HZANz3aKvDKANYon+GUR3N5W8y+4S8T7GNB+2S8nDHbwqpiii
         bCeo0YFJ0qR86EuuOXwv9/i8OjjgbQOjLQ6eLxmfaaBce1VJu0cFofL2xnyiTTBVWbut
         eG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493834; x=1747098634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIAVq6usprfb4K7O7IY6gkWciH8NFY8vqc9fzBoEj10=;
        b=rxLShBKvKlwqgeZ7fxDOghy/MDiIeSCQ+L7Y1e+CqGxdDLY4UqZ0+cklFgNgsBrnA3
         ObLlV3UQ0nEy0jeyxyP18bK/UwMpcSp5dhO3XP73q44x/KMz3GWTfNrz4yyMjwi2LqRu
         uvuIGbikqvR/OptWGBsNLO4nk4GNG4JfVAWF+03CY1S+W1vm50DZKk40vOgaTBGcqg2o
         d+4Nby0bvE7diMnPMRHyb2TgRXlaPMqFbzvLO8HJz85+Cbqc3ZBLD8F2B0HML0BaioAi
         jiRx89QQem2EwhidyNK7dPxPlW0/MVOfNEgdl0kDBGt4mWS1zW+m/upyJrneazIMVmmz
         H3XA==
X-Forwarded-Encrypted: i=1; AJvYcCVKEjNh1DGemTfPd/dRNKp14bw+NB+AU59nUMU8iawjZiJexb/WyG2bETL/8rIEwQf1J2Z5GYLjSHc2NYEO06g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Z6zClhjRmpaHBnc0Ti/bMIqJHJnU01Hy3xGWVZnzz2Mhw0D6
	NCuZBGiEIoOiMa9SdMKTZ4CVVSJdBivBZP7HaJ30UbmVyathhXM=
X-Gm-Gg: ASbGncsRuJe6ycdQYIWz0mA4eky0hdOfr7QcVjaubRON5NUrB+3eIRDSoS0aB/98TZH
	xyCb6vYgPe+9eObtiNm3KSPO+IhdoSapvkggEpIMIe97Ou857mqGtNo1Grz4ZaDQX/M8Ku/vH9j
	Q8QHjWtSw5Axwk1EYjPkZ37V/x06HBjS9be5GagWE78HgasIPUAdT1SFzVdxITLgvhd0waA6jBr
	sxscyLCrICq345LqyHGtLYGcw1fU1NQPdfGblOQ3/fAsvEipGyairsO9KwdpXI8IJjNaxKKOXBv
	AOK8Z6NRavXFAzA+VRuU9x/MJlE1KymdDGVMULhtuR1MAixwfRv0vrfor4g6q31pK5Ncl89MNVA
	=
X-Google-Smtp-Source: AGHT+IHKjbMZ8IYfI652SkfTMgnD06aaXwOTxFJGGXOmjuxBL2UZdz7zJh+7yffLpORHPOO1rQ7q4A==
X-Received: by 2002:a17:902:c94f:b0:220:ca08:8986 with SMTP id d9443c01a7336-22e1ea7f516mr144260185ad.22.1746493833574;
        Mon, 05 May 2025 18:10:33 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e15229399sm61728615ad.187.2025.05.05.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 18:10:33 -0700 (PDT)
Date: Mon, 5 May 2025 18:10:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"jiri @ resnulli . us" <jiri@resnulli.us>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] net: Lock netdevices during dev_shutdown
Message-ID: <aBlhiI7V0EQWEmzk@mini-arch>
References: <20250505194713.1723399-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505194713.1723399-1-cratiu@nvidia.com>

On 05/05, Cosmin Ratiu wrote:
> __qdisc_destroy() calls into various qdiscs .destroy() op, which in turn
> can call .ndo_setup_tc(), which requires the netdev instance lock.
> 
> This commit extends the critical section in
> unregister_netdevice_many_notify() to cover dev_shutdown() (and
> dev_tcx_uninstall() as a side-effect) and acquires the netdev instance
> lock in __dev_change_net_namespace() for the other dev_shutdown() call.
> 
> This should now guarantee that for all qdisc ops, the netdev instance
> lock is held during .ndo_setup_tc().
> 
> Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks!


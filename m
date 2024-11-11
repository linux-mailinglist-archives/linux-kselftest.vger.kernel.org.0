Return-Path: <linux-kselftest+bounces-21782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D609C3E51
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38417283A0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD619C542;
	Mon, 11 Nov 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfmkJQGc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91919939E;
	Mon, 11 Nov 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327387; cv=none; b=LP8jzLw+iLTDIJBGJ5M+q2vpT7Cqm2+AvkzWSSlNgVdiPnKH5tzn3c+L+ni65qGf3TjXtzrxmx3aHWNUUSFfjQA0SvH26kuefH/cho8WGt3GFx3ONBjACVYtg8VdqIg8OTVF89j+kALTTk5bQwIJI7bNtZ4TR9t7wi/mh2J1zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327387; c=relaxed/simple;
	bh=7mo6sfZaqf/C2GpsMEd/48An7YNm5ra6DUxCR3K9Xz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJylSOUeXHWS24jouvmc3OZpOR5pYmkL8bSX/VIgOlfBrmrOyF/O1ZLKVUhgQs7DAOgbspYktq7BUQMviysQwXiG50AiIqeRtwXxUyiXbg+py1TiCgsKFxsOoI9MvwfSbYPCup+GomqPtnS342OD0V8qoinA5lm5kYDyR8CZWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfmkJQGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59422C4CECF;
	Mon, 11 Nov 2024 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327387;
	bh=7mo6sfZaqf/C2GpsMEd/48An7YNm5ra6DUxCR3K9Xz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfmkJQGc+dVcbDsg2yU0siEumWfRzlgARQtnZ/2zvAcl6usBtlsjXIFffd6l+CLsr
	 nAWaBWd57jsVXlLjFB6+2hyznUWtGKAnpEUurvM/CQlOBBbFDaHOnO27/mif6xlwT6
	 J82VgblKud958jVdPkw9+cvb2XOc6KQTjwW7UO096o3GzHSlCxIqYM20JIi1I8xxhE
	 7jgMQQfhnUZ/qQoVCcr0apcxem2ip8uynMxvaHWXEFQ0dPdbkOV2bIcO+c6QyHA+uJ
	 QeyRLZumtk+lvS85nBLjpuUSg8269luq+cnn5xqwkoPPD37avhpA1ugn/8b76NQ5YC
	 8zuU372fqGWAQ==
Date: Mon, 11 Nov 2024 12:16:24 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 6/8] selftests: move macsec offload tests from
 net/rtnetlink to drivers/net/netdvesim
Message-ID: <20241111121624.GZ4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <a1f92c250cc129b4bb111a206c4b560bab4e24a5.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f92c250cc129b4bb111a206c4b560bab4e24a5.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:32AM +0100, Sabrina Dubroca wrote:
> We're going to expand this test, and macsec offload is only lightly
> related to rtnetlink.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>



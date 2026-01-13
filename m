Return-Path: <linux-kselftest+bounces-48881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F4D1A0A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEC23014A3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5861340D98;
	Tue, 13 Jan 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="SvxzNM+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host11-snip4-10.eps.apple.com [57.103.78.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297E283FEF
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319864; cv=none; b=FpN46KdLF4+X7mKdof8zN2gBD0eNxEpw2Oki1+aathWd6UAA+Y6hbjVaBxit0ZFLGztkzmvrBTUgK7DkmdeV67mQbFIoeCCBjKGJeEK7YYMl5zppL08AVa8iEtMcdvcy3ocd204h6OLWQzyGjm2U2ckAdZF8IljOeLrMkgRqPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319864; c=relaxed/simple;
	bh=0vkdgA6r80mxKpfAZplIxC5l8+NyKcyQL7sxtbuQ5wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f81pIWI0P6iIRKuO9T3bT4syRXwSv/gnC0ldZmXgJ50Gn2h3Y07tFXOq751xDrPK8krKqkczgoY1bJvnVH0acIHeWEtvFmyAs1ZtBmVtj2px8ykgMfobOeIwdw9AoHCBsuZ5LxPrgtaoNr01+zxEsif4jtwgSJm0vvPjfqO+fSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=SvxzNM+o reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-3 (Postfix) with ESMTPS id 193E51800295;
	Tue, 13 Jan 2026 15:57:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=iDyf4DVmjcKyNW0ewJj9vMN4f3ffdtug7yHxKcn/nWI=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=SvxzNM+oWtPMtF2uKbra/P9zes1HfLC51jCRSpi5r9ebeYNJ0Ig8pWQOz7zaa8TDOAwcaCC+EGUC494Lz8UsCsaPrWq8mEH5sN+xJPEq2o/uqEEafQhEGoOjuPkB7I7ZVkBKT+vGuRpsqEJdH+XCSygCjXiL843mVNmhFRrAcwYXw/mwYOgUbjo+RXpP0AVBb18sLhByuuIROskjRvkuuo8jxc35rNRl5bZeAwaR6DAaKx45xV7Be4wJaCwrnGOEoeFulheK/nOQmXOOTS1DWrmMxuUi4AlqQGEDCMP/HnXs+/daMjXL3Qzg5H2IUXKsXUqjjVasVcB1F/x1VhORCQ==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-3 (Postfix) with ESMTPSA id 2DBD318006DC;
	Tue, 13 Jan 2026 15:57:36 +0000 (UTC)
Date: Wed, 14 Jan 2026 00:57:33 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: improve error handling
 in passive TFO test
Message-ID: <aWZrbRhat5mw1tnl@desktop.y-koj.net>
References: <cover.1768312014.git.yk@y-koj.net>
 <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
 <607a0338-5e84-4aaf-b705-18dcd4aca05f@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <607a0338-5e84-4aaf-b705-18dcd4aca05f@web.de>
X-Authority-Info: v=2.4 cv=PN0COPqC c=1 sm=1 tr=0 ts=69666b74
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uZvujYp8AAAA:8 a=nPUG_8v1aTBAjSS_qAYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-gmKWNR2uOgA:10
 a=SLzB8X_8jTLwj6mN0q5r:22
X-Proofpoint-ORIG-GUID: 8P5KFWalA--lY3sIqN8O-ciaPhoMwZtx
X-Proofpoint-GUID: 8P5KFWalA--lY3sIqN8O-ciaPhoMwZtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEzMyBTYWx0ZWRfXzE9BXl7XQanw
 AF89VUuuXxtf7nkOrMnjxE+YcnZV2kwJlGoJibuuCqW1dHsJmbxQPOz/GM4j0UREGNncfLOgbKK
 E32K7dxbVJDFEmXDO3H0B8Q8wpyCKQOlsVG4+/IVzRZpN7z36jLnG9fI3niIv2h8wb0DG/eS3Bp
 +979Amo7PRkPdOy+n5+eSwN6yz8f1lJsSNMahV7pP+p/ahrjCzRNKSfSzAYlF2KDUVWc6rWu0eB
 Sbx30CNES+8TXjLMIjDnaNMc6+akP+hWzHLWF4EC1eVwy/fUHC8f/o3TSnBRBMa7lKApd8oPTr6
 3BU4HO84suNlP1Y9vAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1030 malwarescore=0
 adultscore=0 mlxlogscore=854 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601130133
X-JNJ: AAAAAAABEotqHbVajvSgoEhTB8ZHlQ066JYL27IyhwhN9FPZDXZjJxRxdH0qL/A0jLkIKAMUZRsx6/BAmsFPHR2F6RkV51rIAA7l5HqhtIhQoWucsNbCBCf8/HKj4xXW+6LwRhNZ7joY+8ihKD2mvPNEyZmkqzou0sRBH8ZU5B9gErHHDNWpJIHouX6NOpQrcJpk+Qp+CtDl1N7l5qJ4wmm93F48/7+z5OJRyKqbUPphircK6C51qicrN/Qxsz/6+kqLAYkbtpkysm6JZsGUTpodZTvo9IzDGKGwfrhAwGyNyenKUZ1pcelbkYPTAySipN/h713EP6IQNJ/tzjRGvBuozPeGNVe4ma5+P+WfjTSILevXQJS8ynYlFOXk6J2BykRtp73ruHU5GFeXxc1BU3wEsy83qRReJLZ1gGXHmn2JilS5m8P7PAbNAYHGteH39hk5wYxvYBpAIPGLb22nP2hsIcC3/qoK1hmlN8M22LKKkzkO5W+dRYLwylfVSdnxv318HmR8BKRzgYjTE8kXAKYSaEpD1p+46fojkmObUqp8ZuwXDIeqRgyhHJovJCJcZkM46S2hFN+s5LyLWxBcTBwJVzg2jsQCWMVpo6pdTKiVnP/4dGpVhoNiQI6QOC2vkduLNTulALfGSIDizEhFlTYP8I3SaCKeX9WDdS/FF/6tKUbw9d7J9KE8EFuh1CghX+006cJHxZTjhWGTYRRcC9RDaOoe36yP+aN18yw4ukjv2qMWtvcF71q4Ol1rHSS4HRYuv+QYJ6DG

On Tue, Jan 13, 2026 at 03:48:11PM +0100, Markus Elfring wrote:
> …
> > +++ b/tools/testing/selftests/net/tfo.c
> > @@ -82,8 +82,10 @@ static void run_server(void)
> …
> >  	if (read(connfd, buf, 64) < 0)
> > -		perror("read()");
> > -	fprintf(outfile, "%d\n", opt);
> > +		error(1, errno, "read()");
> > +
> > +	if (fprintf(outfile, "%d\n", opt) < 0)
> > +		error(1, errno, "fprintf()");
> >  
> >  	fclose(outfile);
> >  	close(connfd);
> …
> 
> Why was error detection omitted for close() calls here so far?

Because I believe that checking the return value of fclose() would not
provide additional value in this test case, which is focused on testing
the behavior of passive TFO.

I understand that fclose() could fail there, but considering the
trade-off between test reliability and code complexity (which increases
review and maintenance costs), I think checking the return value there
does not provide benefits to justify the added complexity. In fact, as
far as I can see, none of the existing tests in selftests/net check the
fclose() return value.

Thank you,
Yohei

> 
> https://pubs.opengroup.org/onlinepubs/9799919799/functions/fclose.html
> 
> Regards,
> Markus


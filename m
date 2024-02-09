Return-Path: <linux-kselftest+bounces-4424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96884F65C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1819B24057
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C144C9D;
	Fri,  9 Feb 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="ZXIGRKoH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="LVfb6aQ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39B4EB3E;
	Fri,  9 Feb 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487249; cv=none; b=eYUPLL3YxF+R03ZIIrx22Sj3y3c9c7D5DFdoRFuzx4gcWA6XRnRCrtgtIOYdvfZf8QG6VKrP38tpsPZTPikcxcXvvhYPLzYSvuUvpVxnBhbgThI23hV2SrBGaRNcKNICjgUQLiF5O5OOhAxvXtz8d2NjJvQNTFW33MHByS3/a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487249; c=relaxed/simple;
	bh=9R8XflEy1GvVWnHgELQlGqriNJI//CyLvhuzWUd/JI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX+BU++JOP/DHksAEaXbdXP0BX6tWfXtbsSL9zKa61VE0iQc4oBrpn4nC/2slSogr9nnLgjAmfQhgcCC1Kdd/GuK0PL+11Iixs4/yjP2gTs25wvF15cqZHelVytWeLMOHia+1eXIg9Rs/ICH3EVl9od6TAZpgNMr7URI+FPj3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru; spf=pass smtp.mailfrom=internet.ru; dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b=ZXIGRKoH; dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b=LVfb6aQ0; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VxkXegGgaEAXtRmwoqDWMb2Vd2sr4lAgDIoUzVu5F9U=;
	t=1707487245;x=1707577245; 
	b=ZXIGRKoHR8VK5GnNmBNiUAWGAiAdKTWKg/C9rGYCMOsQpg16DrMiFo8IP0V8h6hAUKmKsfmZHW8u+nw9Wg5/DqmsnUsuDDAi6RHFCHbR3EM3BVtc3TsHSQ506ey4timmtq/ibADsLLk4otfq0fmbKYw6rq0bMG+yZlE4Md7djVaF2sk+94eLpJjFZgSw6w5+EiFLyxZo7CAikiN8Bc3hYwWaxWYc7+MSZPz9+zvFqLWDaYmr0tkUw8UUpq1UBe52lboSVwFrtU0b4dOVZ72rg1Z4+WpIwX32JnSZFhsK+wJZBieQwfrtgd3kxk8OLlJO0ewRFFltrMZmSGadVUtrUw==;
Received: from [10.12.4.29] (port=34066 helo=smtp51.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1rYQM7-00Bji8-Gq; Fri, 09 Feb 2024 15:51:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=VxkXegGgaEAXtRmwoqDWMb2Vd2sr4lAgDIoUzVu5F9U=; t=1707483107; x=1707573107; 
	b=LVfb6aQ0X6xJEu+/s/xF/UMwhubC5iKrVDUu1p4LpOfV5OXLKK8CSNzxehGyAWioZr+HFF7FAss
	zLzkaDBeh00Ngd8pWEcI78FFHl3UNFtDxVGBR779wa03JrJvl8eKmC+vg0yURbAPqEUFT8150TouN
	S3Eu+mVVp0+55zLce53Jn9s8Zg9BMWdhH7I66NZhDI2pvI9y3H65vqvlAZUgfjbPyIxBW21XmEjmt
	xYQ00/bsG7obuBecTLYdGDU6i8gXpk9GBaN4NnbLYB+d938IHuFThQIPQFVoRJtOe28gseEECtBaI
	6QxuPlu1QbcFNlWDUDc6AATe4OaZs+7QHpZg==;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rYQLr-00000002uy9-0HxX; Fri, 09 Feb 2024 15:51:31 +0300
Message-ID: <4cab7f95-b4b7-4435-ac70-706ee7a9f7af@internet.ru>
Date: Fri, 9 Feb 2024 15:51:30 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests: net: ip_local_port_range.c:152:17: error: use of
 undeclared identifier 'IPPROTO_MPTCP'
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 lkft-triage@lists.linaro.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com>
From: Maxim Galaganov <max@internet.ru>
In-Reply-To: <CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD91FEFD63CE1B099160922320F7AC456A94DC8673006C014C500894C459B0CD1B9D7F94F945D188441059F388C0C08629F620704A47C80C09DD29AACF440A121D5F82D89A8CF7DB8F5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789066434B85BF7C7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637645995A778B1BFFAEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871DC445240DEB7C3F79CBAE9706FE160F0C5DCEB904BEA41701DF9E95F17B0083B26EA987F6312C9EC1E561CDFBCA1751FBDFBBEFFF4125B51D2E47CDBA5A96583C09775C1D3CA48CFCAFEF312542AECBE117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7ECC8AC47CD0EDEFF8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0CFA063A519E5965DD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3F254576263B31EA9BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3F8A0C55DE5E8D0B235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5D021C19C85C1B7EF5002B1117B3ED696E694C31D5CFF9A30886DC9BC01168B20823CB91A9FED034534781492E4B8EEAD4DBC88E915B2EE6EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF198EE22E71AE2DD9C28E956DD66364A3224249DB96821071B4A889DB714A187017C141E43CE0FC0B766A7423F6D95CBE36CF67735E85545AA1D5625B4B3E74DB77A5FBCDC18C9D73034D55ECCE8C67C6913E6812662D5F2AF819E4E9E0B743E60C42D9497D1EF92B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt6itc0777ZpNqpeiGAWfCQ==
X-Mailru-Sender: 4A46F6E6BB1A04662A3B81E17F92FA49D7F94F945D188441059F388C0C08629F9266CF7AFE747003AF8E75F3432433F792BBD60AF8093D9D3DDE9B364B0DF289325BD006FD28D9A0A3EAC56F6A374A440D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A782CFFFEF9892CBE786A78F94A7442A9D4049FFFDB7839CE9E2038077D049FFA754221AC94B40854C65393021305979B0746BAECE0B58432E6
X-7FA49CB5: 0D63561A33F958A581FCDB0A302B95CAE84D297273A148AC13D0DE3AC07C5D27CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006370A2DD59B67EFEE27389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D56D36E97F3F038CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE73DAC09F78A8B01BF731C566533BA786AA5CC5B56E945C8DA
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt6itc0777ZpPkZY9rHCfFw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 09.02.2024 13:55, Naresh Kamboju wrote:
> I encountered the following build errors while compiling the selftests net
> test cases on Linux next-20240208 tag with clang toolchain.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> selftests/net/ip_local_port_range
> ip_local_port_range.c:152:17: error: use of undeclared identifier
> 'IPPROTO_MPTCP'
>    152 |         .so_protocol    = IPPROTO_MPTCP,
>        |                           ^
> ip_local_port_range.c:176:17: error: use of undeclared identifier
> 'IPPROTO_MPTCP'
>    176 |         .so_protocol    = IPPROTO_MPTCP,
>        |                           ^
> 2 errors generated.
> 
> Build link,
>   - https://storage.tuxsuite.com/public/linaro/lkft/builds/2c4LtUoRSYhdGbErOY8hqHxc6Tu/

The glibc netinet/in.h header in the test container does not have 
IPPROTO_MPTCP definition. It is included first through netinet/ip.h and 
then __UAPI_DEF_IN_IPPROTO is set in linux/libc-compat.h -- so no 
definition comes from include/uapi/linux/in.h either.

# ldd --version
ldd (Debian GLIBC 2.31-13+deb11u7) 2.31
...

# grep -q IPPROTO_MPTCP /usr/include/netinet/in.h ; echo $?
1

I'll send an ifndef/define/endif IPPROTO_MPTCP patch to netdev once it's 
build tested. Thank you for the report.

Broken by commit 122db5e3634b ("selftests/net: add MPTCP coverage for 
IP_LOCAL_PORT_RANGE")

> 
> --
> Linaro LKFT
> https://lkft.linaro.org



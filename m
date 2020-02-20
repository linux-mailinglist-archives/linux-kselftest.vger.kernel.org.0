Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD02165379
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 01:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBTAU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 19:20:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58910 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgBTAU5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 19:20:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K0Dw6E106404;
        Thu, 20 Feb 2020 00:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QWEL2irsvo55ZuVX9rYS+HXpqn01G2Z2MKSCHVrtka0=;
 b=h+lPWXRDgcy4sltXvrrlq8TtBRRSGu1GpX2n8kLYsVaj23Kj2NTvbXVhIcN/t70jst+9
 kF28bH7om4O7uLeBN2un5zoRztPAWsuOF/V0BJavu2kqNnJKfFlaSu/aV3xKDy7VRnir
 tLDY+Q2jKzLPwdSJpMGdEpJQCKxPs1lma9evBRE+YEatgLTQbNZYyjAisVNyMO2/Ec/W
 FUa8piTrGfjGvcNnsJBwWbiHbOn2FSxVjmJMNU7wu5RJG+DMuc40SK1MV7pUz/NO09Ng
 i6OECB/9lwTQxut22NGK+6i0BJdcFG7dNCSxvg/roTyLV3uKJBlvqjI4SZozllsVyaTG uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y8udkek3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 00:20:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K0BlGE024708;
        Thu, 20 Feb 2020 00:18:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y8ud4j3ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 00:18:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01K0InE9026820;
        Thu, 20 Feb 2020 00:18:49 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 16:18:48 -0800
Subject: Re: [PATCH v12 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 docs
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-9-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5f57d4c2-8bf2-e544-a7ba-efb8fe64a25a@oracle.com>
Date:   Wed, 19 Feb 2020 16:18:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211213128.73302-9-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200000
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/20 1:31 PM, Mina Almasry wrote:
> Add docs for how to use hugetlb_cgroup reservations, and their behavior.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Thanks for updating the documentation.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

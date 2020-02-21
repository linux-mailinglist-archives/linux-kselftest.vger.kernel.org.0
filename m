Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB1166BBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 01:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgBUAlc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 19:41:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgBUAlc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 19:41:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L0YQH8169888;
        Fri, 21 Feb 2020 00:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8UF7TnpDrogK96GK/v9GR0EULypgZZOqVd00Gzxcx2g=;
 b=Kqdfpqf6nhyy75vO7hhM1Vjoqo3tKVUKImo42gDEp8MsD2AhfTKY+04p/JTeQJrqsJJy
 lq+fKYoaEmEeH1xYK3IeSV7GRNo/+VWCvDKUYaxnWVYWEoFj2SsW7hELlojWZe66vHPW
 uYzDPfOCgODK+goPQLGPLw6BIkENnOStx74jU8f/pSrRiC/bsGSyaS6YuvWlYrLNssVS
 AkRGApqDJgDgO1XXsjdwKFK+QpLstrVh/K8ypUixojwuwdkaiSe7Q9JwtEwwhofXvQe+
 GMjcpYm+pXhxhu1qrpS5ne5oReqegqTyjXo5pZJi2Q5sOPln90lHKnN6SnCCJmHQM/NL Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud1dbwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 00:41:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L0VtND188030;
        Fri, 21 Feb 2020 00:41:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y8udgpf04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 00:41:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01L0fMlS010627;
        Fri, 21 Feb 2020 00:41:22 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 16:41:22 -0800
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
 <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
 <CAHS8izN_FJektipBwiLsCO8ysMTM7k=CR_k3OV7+_y0ZbrGw+A@mail.gmail.com>
 <20200220162813.aea8a14fe050473b73440323@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0cdd654b-a1f6-fea2-e448-209fbbe14b5c@oracle.com>
Date:   Thu, 20 Feb 2020 16:41:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220162813.aea8a14fe050473b73440323@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210001
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/20/20 4:28 PM, Andrew Morton wrote:
> It all looks pretty good and I expect we can get everything into
> 5.7-rc1, unless some issues pop up.
> 
> It's unclear to me whether
> http://lkml.kernel.org/r/CAHS8izOTipknnYaKz=FdzL-7yW-Z61ck1yPnYWixyMSJuTUYLQ@mail.gmail.com
> was going to result in an update?

Yes there was,

https://lore.kernel.org/linux-mm/20200219233610.13808-1-almasrymina@google.com/

BTW, I've been through the selftest code at a high level.  Not at the level
of detail Shuah may provide.  I am just happy that Mina provided a relatively
comprehensive test for this new functionality.  Will give it an ACK shortly.
-- 
Mike Kravetz

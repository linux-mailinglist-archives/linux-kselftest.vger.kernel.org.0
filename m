Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD515FBC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2020 01:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBOAug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Feb 2020 19:50:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOAug (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Feb 2020 19:50:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01F0mN80095832;
        Sat, 15 Feb 2020 00:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O1PJ+4+ziITIIDCQTVcIjvVNxViqJQWUnTHw+Th26V8=;
 b=VXZRxTZQ2qgIBBqwFKH5ijK5H99sawjGv5ald0By6jX1Lyxvfz1CSEpnTKO9TShUc4rp
 Fdi7ymZp/8MLDbLW2oOwyfGP0SahHyWAz92R/QHuRAr0c0YnEYA3eTzqLGH/dj4oP1oZ
 JohC9KPdlZ5EO5xstF2wwWW2Q3oFRhj4wXenabQyba1lf2h+TCbBJ9XIlPv2NT36HyG/
 Q8Rw9N49X+QgjyPPJl2vjWzBeD/8tSnw9fGmxB0+bj7nZ4iOQTeoLJ0f5cI3MQ0pv1Qy
 FSX/vBG8atTSoS3+yvp1A7W6hpcnNYiJyNtSU6StqUmoVPZtOr67iRIMMR/qJjFOOj7q 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y2p3t486q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 00:50:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01F0lI9Q047814;
        Sat, 15 Feb 2020 00:50:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y4k9nnn1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 00:50:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01F0oRcg025724;
        Sat, 15 Feb 2020 00:50:27 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 16:50:27 -0800
Subject: Re: [PATCH v12 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-2-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <791880db-bdb0-8d34-ea9a-be6e4996fc0d@oracle.com>
Date:   Fri, 14 Feb 2020 16:50:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211213128.73302-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002150002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002150002
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/20 1:31 PM, Mina Almasry wrote:
> Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
> usage or hugetlb reservation counter.
> 
> Adds a new interface to uncharge a hugetlb_cgroup counter via
> hugetlb_cgroup_uncharge_counter.
> 
> Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
> hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

Thanks for the suggested changes.  It will make the code easier to
read and understand.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com

> ---
> 
> Changes in v12:
> - Instead of true/false param for rsvd or non-rsvd calls, now there is:
> hugetlb_cgroup_*() call for non-rsvd
> hugetlb_cgroup_*_rsvd() call for rsvd
> __hugetlb_cgroup_*(, bool) for both.
> - Removed review tags as this patch changed quite a bit.

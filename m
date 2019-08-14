Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566008D5B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfHNONx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 10:13:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHNONx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 10:13:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EEDcPj085298;
        Wed, 14 Aug 2019 14:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=w8S7qTO11ul3944CiOYAHAk7kryjpA0NRFV5XlgZncU=;
 b=fbtwkFKuxPL9ZqpIZ7RKI0Vn44ldgYhX6yH2qfuIyTKBOgWD4Db5XUbKOGwC92sL6DxK
 oOQrFg+Ya/JwQub/Bh8A/nCLo+gOTrzEP6K4rr5FjScXpPeKLV6/JZyUO+AabKg8xl+P
 WK/qtUv0ZRxaKi++GnQcnvHm81SJtpPYgrqccRsztag5JAaVkfD837r7ZSF04HOpgntj
 69FnLmAOzMG6UaE0D/DTdVbk5QxZKV1d952QW6KGVWTeeOsZkodYBDNmwCYz71BCFiSU
 CTDqRd3+NhXGAwwB/oNZZrWlvbtMAAeI6SjLgzF8bZNUizMSncaxkKhplDCotXt2szbR +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u9nbtn5vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 14:13:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EECZKk057021;
        Wed, 14 Aug 2019 14:13:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ubwrh9ws3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 14:13:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7EECUuw002337;
        Wed, 14 Aug 2019 14:12:30 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 07:12:30 -0700
Date:   Wed, 14 Aug 2019 17:12:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dsahern@gmail.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftests: Add nettest
Message-ID: <20190814141224.GA32264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=646
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=696 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140148
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello David Ahern,

The patch acda655fefae: "selftests: Add nettest" from Aug 1, 2019,
leads to the following static checker warning:

	./tools/testing/selftests/net/nettest.c:1690 main()
	warn: unsigned 'tmp' is never less than zero.

./tools/testing/selftests/net/nettest.c
  1680                  case '1':
  1681                          args.has_expected_raddr = 1;
  1682                          if (convert_addr(&args, optarg,
  1683                                           ADDR_TYPE_EXPECTED_REMOTE))
  1684                                  return 1;
  1685  
  1686                          break;
  1687                  case '2':
  1688                          if (str_to_uint(optarg, 0, 0x7ffffff, &tmp) != 0) {
  1689                                  tmp = get_ifidx(optarg);
  1690                                  if (tmp < 0) {

"tmp" is unsigned so it can't be negative.  Also all the callers assume
that get_ifidx() returns negatives on error but it looks like it really
returns zero on error so it's a bit unclear to me.

  1691                                          fprintf(stderr,
  1692                                                  "Invalid device index\n");
  1693                                          return 1;
  1694                                  }
  1695                          }
  1696                          args.expected_ifindex = (int)tmp;
  1697                          break;
  1698                  case 'q':
  1699                          quiet = 1;

regards,
dan carpenter

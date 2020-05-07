Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF821C88F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGLxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 07:53:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEGLxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 07:53:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047BlnMb092151;
        Thu, 7 May 2020 11:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vXRVTWSFpyYPvEhFDwtMilj27ozZ+Flx09viTRMduV0=;
 b=pFYpME+BZVHN4oyCe9NvtBXcTt6QUtXw1/+NzTmJE8E5lSU6xhNqGbdI+Trb3kkksgfu
 sSRf6nojpnUoWH4HpEI7GuA3mvuG8kmcdg2c7rpqepA6eHb9qaZTA4oYDHjCGMrp+2wO
 5mfjYFHf8XMKn3jMzRnMZHe8WwQkmYzNPDe/PG8zxUlQFw76jUOixZ5hgxR4YLhK9Fat
 KLgXHROagaPBnr13yg6+yxDlp29lZuk+huwOgGNivltpQ8tCrJSTDUmS5+9kdgR4TaFX
 HZdQOpO9xYsP5wm5yE03A78oisMu3e55t6+t3FlqtpcmzZvYawmTawYpANlpNBPzwFvx UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09rfntm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 11:53:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047BlWfa130527;
        Thu, 7 May 2020 11:51:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30sjnp1yrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 11:51:03 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047Bp2bE025735;
        Thu, 7 May 2020 11:51:02 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 04:51:02 -0700
Date:   Thu, 7 May 2020 14:50:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     sai.praneeth.prakhya@intel.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/resctrl: Add callback to start a benchmark
Message-ID: <20200507115056.GA252660@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=998 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=3
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070096
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Sai Praneeth Prakhya,

The patch 7f4d257e3a2a: "selftests/resctrl: Add callback to start a
benchmark" from Jan 16, 2020, leads to the following static checker
warning:

	tools/testing/selftests/resctrl/resctrl_val.c:545 measure_vals()
	warn: 'bw_imc' unsigned <= 0

	tools/testing/selftests/resctrl/resctrl_val.c:549 measure_vals()
	warn: 'bw_resc_end' unsigned <= 0

tools/testing/selftests/resctrl/resctrl_val.c
   531  static int
   532  measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
   533  {
   534          unsigned long bw_imc, bw_resc, bw_resc_end;
   535          int ret;
   536  
   537          /*
   538           * Measure memory bandwidth from resctrl and from
   539           * another source which is perf imc value or could
   540           * be something else if perf imc event is not available.
   541           * Compare the two values to validate resctrl value.
   542           * It takes 1sec to measure the data.
   543           */
   544          bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
   545          if (bw_imc <= 0)
                    ^^^^^^^^^^^
Unsigned.  Also the comments for get_mem_bw_imc() says that zero is
success.

   546                  return bw_imc;
   547  
   548          bw_resc_end = get_mem_bw_resctrl();
   549          if (bw_resc_end <= 0)
                    ^^^^^^^^^^^^^^^^
Unsigned

   550                  return bw_resc_end;
   551  
   552          bw_resc = (bw_resc_end - *bw_resc_start) / MB;
   553          ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
   554          if (ret)
   555                  return ret;
   556  
   557          *bw_resc_start = bw_resc_end;
   558  
   559          return 0;
   560  }

regards,
dan carpenter

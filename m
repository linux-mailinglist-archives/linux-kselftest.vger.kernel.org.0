Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E63DAE1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhG2VU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 17:20:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229891AbhG2VU7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 17:20:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TL4KOb137276;
        Thu, 29 Jul 2021 17:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jyCvqbHXhoijR/LghlA8ZIbjtVPzpyfvGFlPJTpoWvk=;
 b=FpOx+rK5Ozw7bWGEU+lSOt7dMzsKx+k5DMVtYITm5DVkneZJI8DwR2j4CUjYz1iVy8NF
 FHG3RvhUHjSxvJFQeDAqNW9TNhdo/Xlbu9gEMOUmHAsSLSD1d9wwpv1Xh9COsSt+sUVa
 bBmECM7bkgK8+qSkt6+s6pL7PSKT4cSZys1bTo8x113Uk3IxCe0yzz1u6FBm16Rc6ri9
 YVAvfKqnLHcBtgj2+q2a0YJKUT67CGW/uaBbLpcG/GRgMflsMlWPpvHzjBajfzIwms4u
 ReWrEFu2fU/f/jYFW/qV6win7sIlDkXMwDepq0F0hfHsShp31ES63RA3bjw5Fll8MUVZ +Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a43aesbju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 17:20:49 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TL8Lu8032087;
        Thu, 29 Jul 2021 21:20:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3a417pgfev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 21:20:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TLKiRD18153806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 21:20:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2AD74204F;
        Thu, 29 Jul 2021 21:20:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77E2B42042;
        Thu, 29 Jul 2021 21:20:43 +0000 (GMT)
Received: from sig-9-65-212-145.ibm.com (unknown [9.65.212.145])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jul 2021 21:20:43 +0000 (GMT)
Message-ID: <c9dffd9d29df095660beaa631ff252c4b33629a0.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jul 2021 17:20:42 -0400
In-Reply-To: <20210726163700.2092768-7-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
         <20210726163700.2092768-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o_UQqp1R-xJtM5F5zagPBR5ZLTR9wKwZ
X-Proofpoint-ORIG-GUID: o_UQqp1R-xJtM5F5zagPBR5ZLTR9wKwZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_17:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290129
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Roberto,

On Mon, 2021-07-26 at 18:36 +0200, Roberto Sassu wrote:
> /*
> + * digest_list_read: read and parse the digest list from the path
> + */
> +static ssize_t digest_list_read(char *path, enum ops op)
> +{
> +       void *data = NULL;
> +       char *datap;
> +       size_t size;
> +       u8 actions = 0;
> +       struct file *file;
> +       char event_name[NAME_MAX + 9 + 1];
> +       u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
> +       enum hash_algo algo;
> +       int rc, pathlen = strlen(path);
> +
> +       /* Remove \n. */
> +       datap = path;
> +       strsep(&datap, "\n");
> +
> +       file = filp_open(path, O_RDONLY, 0);
> +       if (IS_ERR(file)) {
> +               pr_err("unable to open file: %s (%ld)", path, PTR_ERR(file));
> +               return PTR_ERR(file);
> +       }
> +
> +       rc = kernel_read_file(file, 0, &data, INT_MAX, NULL,
> +                             READING_DIGEST_LIST);
> +       if (rc < 0) {
> +               pr_err("unable to read file: %s (%d)", path, rc);
> +               goto out;
> +       }
> +
> +       size = rc;
> +
> +       snprintf(event_name, sizeof(event_name), "%s_file_%s",
> +                op == DIGEST_LIST_ADD ? "add" : "del",
> +                file_dentry(file)->d_name.name);
> +
> +       rc = ima_measure_critical_data("diglim", event_name, data, size, false,
> +                                      digest, sizeof(digest));
> +       if (rc < 0 && rc != -EEXIST)
> +               goto out_vfree;

The digest lists could easily be measured while reading the digest list
file above in kernel_read_file().  What makes it "critical-data"?  In
the SELinux case, the in memory SELinux policy is being measured and
re-measured to make sure it hasn't been modified.  Is the digest list
file data being measured more than once?

I understand that with your changes to ima_measure_critical_data(),
which are now in next-integrity-testing branch, allow IMA to calculate
the file data hash.

thanks,

Mimi

> +
> +       algo = ima_get_current_hash_algo();
> +



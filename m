Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D309123E3C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgHFWIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 18:08:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgHFWIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 18:08:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076M2RvK019382;
        Thu, 6 Aug 2020 18:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oL8rfatTQ117+qM6l9H41acaUXAS4Gv8Ss5dDG9xkOo=;
 b=dPT1DcqnvyKDulRVjsH7eMqJv7UIuPBwuaKc0+J7RacBYmt33DP7yKh5ntonCswr9Up5
 9PBbRhRJPr1LI+NXub8PwHV5HOAAc0yStNq4SGAXQfmAbtWoiVo237zIHRSbdtOvpTNu
 oBcwO+dabJhvGJi1oYZD5AuhLKP496XkmQFeR45XVMDALSCreOaL11OsLTMUtrlD5TGU
 FnLGW7Gv2dzUYrENG7i3JRtax+T9EaA4hxrUAnlEzu1V+mv5iyv/39WvqSpLH0G7PipC
 ONV685tjkljX+1Y4um7D/MzpJli4u992EJiBD5rODnVTk9lqHvx5ltMdZ52Vx6zITkUR ZQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rfm9kchu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 18:07:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076M75vL019809;
        Thu, 6 Aug 2020 22:07:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 32mynh5vv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 22:07:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076M7nYJ24510744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 22:07:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B58D52054;
        Thu,  6 Aug 2020 22:07:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4F04052050;
        Thu,  6 Aug 2020 22:07:46 +0000 (GMT)
Message-ID: <6be709297b60260faf9fb8b741799d130a663d52.camel@linux.ibm.com>
Subject: Re: [PATCH v4 10/17] firmware_loader: Use security_post_load_data()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Aug 2020 18:07:35 -0400
In-Reply-To: <20200729175845.1745471-11-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
         <20200729175845.1745471-11-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_17:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-29 at 10:58 -0700, Kees Cook wrote:
> Now that security_post_load_data() is wired up, use it instead
> of the NULL file argument style of security_post_read_file(),
> and update the security_kernel_load_data() call to indicate that a
> security_kernel_post_load_data() call is expected.
> 
> Wire up the IMA check to match earlier logic. Perhaps a generalized
> change to ima_post_load_data() might look something like this:
> 
>     return process_buffer_measurement(buf, size,
>                                       kernel_load_data_id_str(load_id),
>                                       read_idmap[load_id] ?: FILE_CHECK,
>                                       0, NULL);
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Other than one change and one question below, it looks good.

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

<snip>

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 85000dc8595c..1a7bc4c7437d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c

> @@ -706,7 +697,7 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
>  		}
>  		break;
>  	case LOADING_FIRMWARE:
> -		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
> +		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE) && !contents) {
>  			pr_err("Prevent firmware sysfs fallback loading.\n");

Appended signatures are limited to kernel modules and, more recently,
to the kexec kernel image, not firmware.  Without a file descriptor,
file signatures stored as an xattrs are not applicable either.  We
might as well fail earlier, rather than later.  Adding "!contents" is
unnecessary.

>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> @@ -739,6 +730,15 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
>   */
>  int ima_post_load_data(char *buf, loff_t size, enum kernel_load_data_id load_id)
>  {
> +	if (load_id == LOADING_FIRMWARE) {
> +		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("Prevent firmware loading_store.\n");
> +			return -EACCES; /* INTEGRITY_UNKNOWN */
> +		}
> +		return 0;
> +	}

Even with failing LOADING_FIRMWARE early in ima_load_data(), is this
still needed for fw_sysfs_loading()?

thanks,

Mimi

> +
>  	return 0;
>  }
>  


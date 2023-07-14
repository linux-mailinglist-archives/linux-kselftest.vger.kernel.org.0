Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58498753932
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjGNLEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 07:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGNLEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 07:04:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF2CC0;
        Fri, 14 Jul 2023 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332645; x=1720868645;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=14/EGw9zs/MnEK47r/Ig3i5bPbQSg8aFLqH9hbjcMao=;
  b=nRXb2ndWRn+79+viyLqgsi/KlFwaxnbXJFCH23fVGtRDEFSeyj82oVMO
   5UgdOYmTFrGveAu+QcE3E66+2mBR34g2Lpg1AxrNgvGks4xEZjsG5fgTX
   3Feu9J1vNOUQcJMuyn6ykdQXPGTIcPGvG9zL2RVxv0Oi3yUIWQuIKFX//
   wkyWyJzwp1JmKMjNIfLVpwwVlaybkQ0b/RdtL9CZjF2kzj7oXwW8XtkdK
   +Emvkf1YPwHFnE3QjIgnysn//bKdoNS2mL1qo52fZyI33sC4YBQSPXSDY
   /RoJbbmIYIcPurprFjkU2q9MbmxxZV6lOfK0ctW5R9hCShEB35ILqhoPB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365485612"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="365485612"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="672653053"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="672653053"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:03:49 -0700
Date:   Fri, 14 Jul 2023 14:03:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/19] selftests/resctrl: Refactor remount_resctrl(bool
 mum_resctrlfs) to mount_resctrl()
In-Reply-To: <09605219-19db-ba2d-aaad-9e279543f461@intel.com>
Message-ID: <2c1f4d5f-7d6f-1178-7ec4-7f8b862b26e9@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-8-ilpo.jarvinen@linux.intel.com> <09605219-19db-ba2d-aaad-9e279543f461@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1368666242-1689332631=:1695"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1368666242-1689332631=:1695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 13 Jul 2023, Reinette Chatre wrote:
> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> > Mount/umount of the resctrl FS is now paired nicely per test.
> > 
> > Rename remount_resctrl(bool mum_resctrlfs) to mount_resctrl(). Make
> > it unconditionally try to mount the resctrl FS and return error if
> > resctrl FS was mounted already.
> > 
> > While at it, group the mount/umount prototypes in the header.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
> >  .../testing/selftests/resctrl/resctrl_tests.c |  8 ++++----
> >  tools/testing/selftests/resctrl/resctrlfs.c   | 20 +++++--------------
> >  3 files changed, 10 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index f455f0b7e314..23af3fb73cb4 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -85,8 +85,8 @@ extern char llc_occup_path[1024];
> >  int get_vendor(void);
> >  bool check_resctrlfs_support(void);
> >  int filter_dmesg(void);
> > -int remount_resctrlfs(bool mum_resctrlfs);
> >  int get_resource_id(int cpu_no, int *resource_id);
> > +int mount_resctrlfs(void);
> >  int umount_resctrlfs(void);
> >  int validate_bw_report_request(char *bw_report);
> >  bool validate_resctrl_feature_request(const char *resctrl_val);
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index a421d045de08..3f26d2279f75 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -77,7 +77,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
> >  
> >  	ksft_print_msg("Starting MBM BW change ...\n");
> >  
> > -	res = remount_resctrlfs(true);
> > +	res = mount_resctrlfs();
> >  	if (res) {
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >  		return;
> > @@ -106,7 +106,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
> >  
> >  	ksft_print_msg("Starting MBA Schemata change ...\n");
> >  
> > -	res = remount_resctrlfs(true);
> > +	res = mount_resctrlfs();
> >  	if (res) {
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >  		return;
> > @@ -132,7 +132,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
> >  
> >  	ksft_print_msg("Starting CMT test ...\n");
> >  
> > -	res = remount_resctrlfs(true);
> > +	res = mount_resctrlfs();
> >  	if (res) {
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >  		return;
> > @@ -160,7 +160,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
> >  
> >  	ksft_print_msg("Starting CAT test ...\n");
> >  
> > -	res = remount_resctrlfs(true);
> > +	res = mount_resctrlfs();
> >  	if (res) {
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >  		return;
> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> > index b3a05488d360..f622245adafe 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -48,29 +48,19 @@ static int find_resctrl_mount(char *buffer)
> >  }
> >  
> >  /*
> > - * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
> > - * @mum_resctrlfs:	Should the resctrl FS be remounted?
> > + * mount_resctrlfs - Mount resctrl FS at /sys/fs/resctrl
> >   *
> >   * If not mounted, mount it.
> > - * If mounted and mum_resctrlfs then remount resctrl FS.
> > - * If mounted and !mum_resctrlfs then noop
> >   *
> >   * Return: 0 on success, non-zero on failure
> >   */
> 
> Since it is not obviously a "failure" I do think it will help to
> add to the comments that resctrl already being mounted is treated as
> a failure.
> 
> > -int remount_resctrlfs(bool mum_resctrlfs)
> > +int mount_resctrlfs(void)
> >  {
> > -	char mountpoint[256];
> >  	int ret;
> >  
> > -	ret = find_resctrl_mount(mountpoint);
> > -	if (ret)
> > -		strcpy(mountpoint, RESCTRL_PATH);
> > -
> > -	if (!ret && mum_resctrlfs && umount(mountpoint))
> > -		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
> > -
> > -	if (!ret && !mum_resctrlfs)
> > -		return 0;
> > +	ret = find_resctrl_mount(NULL);
> > +	if (!ret)
> > +		return -1;
> 
> This treats "ret == 0" as a failure. What about -ENXIO? It seems to
> me that only "ret == -ENOENT" is "success".

Yes, it's a good catch.

-- 
 i.
--8323329-1368666242-1689332631=:1695--
